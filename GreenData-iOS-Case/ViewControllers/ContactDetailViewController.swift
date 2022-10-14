//
//  ContactDetailViewController.swift
//  GreenData-iOS-Case
//
//  Created by Igor Buzykin on 11.10.2022.
//

import Kingfisher
import SimpleImageViewer
import UIKit

final class ContactDetailViewController: UIViewController {
  // MARK: - IBOutlets

  @IBOutlet var contactImageView: UIImageView!
  @IBOutlet var birthdateLabel: UILabel!
  @IBOutlet var deviceTimeLabel: UILabel!
  @IBOutlet var contactTimeLabel: UILabel!
  @IBOutlet var numberLabel: UILabel!
  @IBOutlet var mailLabel: UILabel!
  
  @IBOutlet var genderImageView: UIImageView!
  @IBOutlet var genderLabel: UILabel!
  
  // MARK: - Internal properties

  var contact: Contact!
  
  // MARK: - Private properties

  // Managers
  private let dateManager = DateManager()
  
  // Flow properties
  private var phoneURL: URL?
  private var mailURL: URL?
  
  // MARK: - VC lifecycle methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  // MARK: - Flow private methods
  
  private func configureUI() {
    title = contact.fullname
    configureLabels()
    configureGenderInfo()
    configureImageView()
    configureTime()
    validatePhoneNumber()
    validateMail()
    configureGestureRecognizers()
  }
  
  private func configureLabels() {
    let birthDate = dateManager.parseISO8601Date(string: contact.birthdayDate) ?? "N/A"
    birthdateLabel.text = "\(birthDate) (\(contact.birthdayAge))"
    numberLabel.text = contact.phoneNumber
    mailLabel.text = contact.mail
  }
  
  private func configureTime() {
    dateManager.startTrackingLiveTime(for: contact.localTimeOffset) {
      [weak self] contactTime, deviceTime in
      guard let self = self else { return }
      self.contactTimeLabel.text = "Местное: \(contactTime)"
      self.deviceTimeLabel.text = "Ваше: \(deviceTime)"
    }
  }
  
  private func configureGenderInfo() {
    genderLabel.text = contact.gender.presentTitle
    genderImageView.image = UIImage(named: contact.gender.imageName)
  }
  
  private func configureImageView() {
    contactImageView.kf.setImage(
      with: URL(string: contact.picURL),
      placeholder: UIImage(named: contact.gender == .female ? "person-dress-solid" : "person-solid")
    )
    contactImageView.layer.cornerRadius = 10
    contactImageView.layer.masksToBounds = true
  }
  
  private func validatePhoneNumber() {
    let number = contact.phoneNumber.replacingOccurrences(
      of: "[^0-9]",
      with: "",
      options: .regularExpression
    )
    guard let phoneURL = URL(string: "tel://\(number)") else { return }
    if UIApplication.shared.canOpenURL(phoneURL) {
      Log.d("Phone calling available")
      numberLabel.textColor = .systemBlue
      self.phoneURL = phoneURL
    }
  }
  
  private func validateMail() {
    guard let mailULR = URL(string: "mailto:\(contact.mail)") else { return }
    if UIApplication.shared.canOpenURL(mailULR) {
      mailLabel.textColor = .systemBlue
      mailURL = mailULR
    }
  }
  
  private func configureGestureRecognizers() {
    let imageViewTapGesture = UITapGestureRecognizer(
      target: self,
      action: #selector(imageViewTapDetected)
    )
    contactImageView.addGestureRecognizer(imageViewTapGesture)
    
    let numberLabelTapGesture = UITapGestureRecognizer(
      target: self,
      action: #selector(numberLabelTapDetected)
    )
    numberLabel.addGestureRecognizer(numberLabelTapGesture)
    
    let mailLabelTapGesture = UITapGestureRecognizer(
      target: self,
      action: #selector(mailLabelTapDetected)
    )
    mailLabel.addGestureRecognizer(mailLabelTapGesture)
  }
  
  // MARK: - Gesture Actions
  
  @objc
  private func imageViewTapDetected() {
    let configuration = ImageViewerConfiguration { config in
      config.image = contactImageView.image
    }
    let imageViewer = ImageViewerController(configuration: configuration)
    present(imageViewer, animated: true)
  }
  
  @objc
  private func numberLabelTapDetected() {
    if let phoneURL = phoneURL {
      UIApplication.shared.open(phoneURL)
    }
  }
  
  @objc
  private func mailLabelTapDetected() {
    if let mailURL = mailURL {
      UIApplication.shared.open(mailURL)
    }
  }
}
