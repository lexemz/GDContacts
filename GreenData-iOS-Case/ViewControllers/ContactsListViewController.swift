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
  
  private var contacts: [ContactRepresentable] = []
  
  // MARK: - VC lifecycle methods

  override func viewDidLoad() {
    super.viewDidLoad()
    contactsManager.delegate = self
    configureTableView()
    contactsManager.fetchContacts()
  }
  
  // MARK: - Flow methods
  
  private func configureTableView() {
    tableView.register(
      ContactViewCell.self,
      forCellReuseIdentifier: ContactViewCell.reuseIdentifier
    )
    tableView.rowHeight = 85
  }

  private func openContantViewController(with contact: ContactRepresentable) {
    let contactVC = ContactDetailViewController.instanceFromStoryboard()
    contactVC.contact = contact
    navigationController?.pushViewController(contactVC, animated: true)
  }
  
  private func fetchContactsFromManager() {
    contactsManager.fetchContacts()
  }
  
  // MARK: - TableViewDataSource
  override func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    contacts.count
  }

  override func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: ContactViewCell.reuseIdentifier
    ) as! ContactViewCell
    
    cell.configure(with: contacts[indexPath.row])
    
    if indexPath.row == contacts.count - 3 {
      loadMoreContacts()
    }
    return cell
  }
  
  // MARK: - TableViewDelegate
  
  override func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath
  ) {
    tableView.deselectRow(at: indexPath, animated: true)
    openContantViewController(with: contacts[indexPath.row])
  }
  
  // MARK: - Flow methods
  
  private func loadMoreContacts() {
    contactsManager.fetchContacts()
  }
}

// MARK: - ContactsManagerDelegate

extension ContactsListViewController: ContactsManagerDelegate {
  func contactsManager(
    _ contactsManager: ContactsManager,
    didReceive contacts: [ContactRepresentable]
  ) {
    Log.d(contacts)
    DispatchQueue.main.async {
      self.contacts += contacts
      self.tableView.reloadData()
    }
  }
  
  func contactsManager(
    _ contactsManager: ContactsManager,
    didReceive error: NetworkManagerError
  ) {
    // TODO: Show Alert
    Log.d(error)
  }
}
