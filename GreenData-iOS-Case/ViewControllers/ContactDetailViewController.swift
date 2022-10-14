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
  @IBOutlet var contactImageView: UIImageView!
  @IBOutlet var birthdateLabel: UILabel!
  @IBOutlet var localTimeLabel: UILabel!
  @IBOutlet var userTimeLabel: UILabel!
  @IBOutlet var numberLabel: UILabel!
  @IBOutlet var mailLabel: UILabel!
  
  @IBOutlet var genderImageView: UIImageView!
  @IBOutlet var genderLabel: UILabel!
  
  var contact: Contact!
  let dateManager = DateManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    setupGestureRecognizers()
  }
  
  private func configureUI() {
    title = contact.fullname
    
    let birthDate = dateManager.parseISO8601Date(string: contact.birthdayDate) ?? "N/A"
    birthdateLabel.text = "\(birthDate) (\(contact.birthdayAge))"
    numberLabel.text = contact.phoneNumber
    mailLabel.text = contact.mail
    
    userTimeLabel.text = "Наше: \(dateManager.getCurrentTime())"
    let localTime = dateManager.getTimeByTimezone(timezone: contact.localTimeOffset) ?? "N/A"
    localTimeLabel.text = "Местное \(localTime)"
    genderLabel.text = contact.gender.presentTitle
    genderImageView.image = UIImage(named: contact.gender.imageName)
    contactImageView.kf.setImage(with: URL(string: contact.picURL))
    contactImageView.layer.cornerRadius = 10
    contactImageView.layer.masksToBounds = true
  }
  
  private func setupGestureRecognizers() {
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
