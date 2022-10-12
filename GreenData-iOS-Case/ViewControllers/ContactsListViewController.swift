//
//  ContactsListViewController.swift
//  GreenData-iOS-Case
//
//  Created by Igor Buzykin on 11.10.2022.
//

import UIKit

class ContactsListViewController: UIViewController {
  @IBOutlet var tableView: UITableView!
  @IBOutlet var mainActivityIndicator: UIActivityIndicatorView!

  // MARK: - Private props

  // Managers
  private let contactsManager = ContactsManager()

  // Flow Properties
  private var contacts: [ContactRepresentable] = []

  // MARK: - VC lifecycle methods

  override func viewDidLoad() {
    super.viewDidLoad()

    configureTableView()
    configureContactsManager()
  }

  // MARK: - Flow methods

  private func openContantViewController(with contact: ContactRepresentable) {
    let contactVC = ContactDetailViewController.instanceFromStoryboard()
    contactVC.contact = contact
    navigationController?.pushViewController(contactVC, animated: true)
  }

  private func configureTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(
      ContactViewCell.self,
      forCellReuseIdentifier: ContactViewCell.reuseIdentifier
    )
    tableView.rowHeight = 85
  }

  private func configureContactsManager() {
    contactsManager.delegate = self
    contactsManager.fetchContacts()
    showActivityIndicator()
  }

  private func showActivityIndicator() {
    mainActivityIndicator.startAnimating()
  }

  private func hideActivityIndicator() {
    mainActivityIndicator.stopAnimating()
  }
}

// MARK: - TableViewDataSource

extension ContactsListViewController: UITableViewDataSource {
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    contacts.count
  }

  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: ContactViewCell.reuseIdentifier,
      for: indexPath
    ) as! ContactViewCell

    cell.configure(with: contacts[indexPath.row])

    if indexPath.row == contacts.count - 1 {
      contactsManager.fetchContacts()
    }
    return cell
  }
}

// MARK: - TableViewDelegate

extension ContactsListViewController: UITableViewDelegate {
  func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath
  ) {
    tableView.deselectRow(at: indexPath, animated: true)
    openContantViewController(with: contacts[indexPath.row])
  }

  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    let lastRowIndex = tableView.numberOfRows(inSection: 0) - 1
    if indexPath.row == lastRowIndex {
      let activity = UIActivityIndicatorView()
      activity.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 40)
      activity.startAnimating()
      tableView.tableFooterView = activity
    }
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
      self.hideActivityIndicator()
    }
  }

  func contactsManager(
    _ contactsManager: ContactsManager,
    didReceive error: NetworkManagerError
  ) {
    // TODO: Show Alert
    tableView.tableFooterView?.isHidden = true
    Log.d(error)
  }
}
