//
//  ContactsListViewController.swift
//  GreenData-iOS-Case
//
//  Created by Igor Buzykin on 11.10.2022.
//

import UIKit

final class ContactsListViewController: UIViewController {
  @IBOutlet var tableView: UITableView!
  @IBOutlet var mainActivityIndicator: UIActivityIndicatorView!

  // MARK: - Private props

  // Managers
  private let contactsManager = ContactsManager()

  // Flow Properties
  private var contacts: [Contact] = []
  private var networkErrorDidShow = false

  // MARK: - VC lifecycle methods

  override func viewDidLoad() {
    super.viewDidLoad()

    configureTableView()
    configureContactsManager()
  }

  // MARK: - Flow methods

  private func openContantViewController(with contact: Contact) {
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

  private func createActivityIndicationOnTableFooter() {
    let activity = UIActivityIndicatorView()
    activity.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 40)
    activity.startAnimating()
    activity.hidesWhenStopped = true
    tableView.tableFooterView = activity
  }

  private func removeActivityIndicatorOnTableFooter() {
    tableView.tableFooterView = nil
  }

  private func createOfflineInfoButton() {
    let barButton = UIBarButtonItem(
      image: UIImage(systemName: "icloud.slash"),
      style: .plain,
      target: self,
      action: #selector(offlineInfoButtonTap)
    )
    barButton.tintColor = .systemRed
    navigationItem.rightBarButtonItem = barButton
  }

  @objc
  private func offlineInfoButtonTap() {
    showInfoAlert(
      title: "Оффлайн режим",
      message: "Похоже, ваше устройство не может выйти в сеть.\nВосстановлена последняя сессия."
    )
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

  func tableView(
    _ tableView: UITableView,
    willDisplay cell: UITableViewCell,
    forRowAt indexPath: IndexPath
  ) {
    let lastRowIndex = tableView.numberOfRows(inSection: 0) - 1
    if indexPath.row == lastRowIndex {
      contactsManager.fetchContacts()
    }
  }
}

// MARK: - ContactsManagerDelegate

extension ContactsListViewController: ContactsManagerDelegate {
  func contactsManager(
    _ contactsManager: ContactsManager,
    didReceive contacts: [Contact]
  ) {
    DispatchQueue.main.async {
      self.contacts += contacts
      self.tableView.reloadData()
      self.hideActivityIndicator()
      self.createActivityIndicationOnTableFooter()
      self.networkErrorDidShow = false
    }
  }

  func contactsManager(
    _ contactsManager: ContactsManager,
    didReceive event: ContactManagerEvents
  ) {
    DispatchQueue.main.async {
      switch event {
      case .networkError(let error):
        if !self.networkErrorDidShow {
          self.showInfoAlert(title: "Ошибка сети", message: error.localizedDescription)
          self.networkErrorDidShow = true
        }
        self.removeActivityIndicatorOnTableFooter()
      case .offlineModeEnabled:
        self.createOfflineInfoButton()
        self.removeActivityIndicatorOnTableFooter()
      }
    }
  }
}
