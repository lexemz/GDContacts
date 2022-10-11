//
//  ContactsListViewController.swift
//  GreenData-iOS-Case
//
//  Created by Igor Buzykin on 11.10.2022.
//

import UIKit

class ContactsListViewController: UITableViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  private func openContantViewController() {
    let contactVC = ContactDetailViewController.instanceFromStoryboard()
    navigationController?.pushViewController(contactVC, animated: true)
  }
  
  @IBAction func openDetailTap(_ sender: UIBarButtonItem) {
    openContantViewController()
  }
}
