//
//  ContactsListViewController.swift
//  GreenData-iOS-Case
//
//  Created by Igor Buzykin on 11.10.2022.
//

import UIKit

class ContactsListViewController: UITableViewController {
  // MARK: - Private props
  private let contactsManager = ContactsManager()

  override func viewDidLoad() {
    super.viewDidLoad()
    contactsManager.delegate = self
  }

  // MARK: - IBActions
  @IBAction func openDetailTap(_ sender: UIBarButtonItem) {
    openContantViewController()
  }
  
  @IBAction func fetchContactsTap(_ sender: UIBarButtonItem) {
    fetchContactsFromManager()
  }
  
  // MARK: - Flow methods
  private func openContantViewController() {
    let contactVC = ContactDetailViewController.instanceFromStoryboard()
    navigationController?.pushViewController(contactVC, animated: true)
  }
  
  private func fetchContactsFromManager() {
    contactsManager.startFetchContacts()
  }
  
  // MARK: - TableViewDataSource
//  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    <#code#>
//  }
//
//  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    <#code#>
//  }
}

// MARK: - ContactsManagerDelegate

extension ContactsListViewController: ContactsManagerDelegate {
  func handle(_ from: ContactsManager, receivedContacts: [ContactRepresentable]) {
    // TODO: Handle Contacts
    Log.d(receivedContacts)
  }

  func handle(_ from: ContactsManager, receivedError: NetworkManagerError) {
    // TODO: Show Alert
    Log.d(receivedError)
  }
}
