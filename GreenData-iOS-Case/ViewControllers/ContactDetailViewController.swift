//
//  ContactDetailViewController.swift
//  GreenData-iOS-Case
//
//  Created by Igor Buzykin on 11.10.2022.
//

import UIKit
import Kingfisher

class ContactDetailViewController: UIViewController {
  
  @IBOutlet var contactImageView: UIImageView!
  @IBOutlet var birthdateLabel: UILabel!
  @IBOutlet var localTimeLabel: UILabel!
  @IBOutlet var userTimeLabel: UILabel!
  @IBOutlet var numberLabel: UILabel!
  @IBOutlet var mailLabel: UILabel!
  
  var contact: ContactRepresentable!
  let dateManager = DateManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
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
    
    contactImageView.kf.setImage(with: URL(string: contact.picURL))
    contactImageView.layer.cornerRadius = 10
    contactImageView.layer.masksToBounds = true
  }
}
