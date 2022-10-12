//
//  ContactDetailViewController.swift
//  GreenData-iOS-Case
//
//  Created by Igor Buzykin on 11.10.2022.
//

import UIKit

class ContactDetailViewController: UIViewController {
  
  var contact: ContactRepresentable!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = contact.fullname
  }
}
