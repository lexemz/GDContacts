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

  private let dateManager = DateManager()
  
  // MARK: - VC lifecycle methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    configureGestureRecognizers()
  }
  
  // MARK: - Flow private methods
  
  private func configureUI() {
    title = contact.fullname
    configureLabels()
    configureGenderInfo()
    configureImageView()
    configureTime()
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
      self.deviceTimeLabel.text = "Наше: \(deviceTime)"
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
  
  private func configureGestureRecognizers() {
    let tapGestureRecognizer = UITapGestureRecognizer(
      target: self,
      action: #selector(imageViewTapDetected)
    )
    contactImageView.addGestureRecognizer(tapGestureRecognizer)
  }
  
  @objc
  private func imageViewTapDetected() {
    let configuration = ImageViewerConfiguration { config in
      config.imageView = contactImageView
    }
    let imageViewer = ImageViewerController(configuration: configuration)
    present(imageViewer, animated: true)
  }
}
