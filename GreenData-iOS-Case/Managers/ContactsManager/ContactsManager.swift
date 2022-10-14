//
//  ContactsManager.swift
//  GreenData-iOS-Case
//
//  Created by Igor Buzykin on 11.10.2022.
//

import Foundation

final class ContactsManager {
  var delegate: ContactsManagerDelegate?

  private let networkManager = NetworkManager.shared
  private let coreDataManager = CoreDataManager.shared
  private var requestPage = 1
  private var offlineMode = !NetworkManager.shared.isOnline
  private var backupDataDidShow = false

  func fetchContacts() {
    networkManager.fetch(
      RandomUserJSON.self,
      with: [
        "page": "\(requestPage)",
        "results": "10",
        "seed": "lexemz.seed"
      ]
    ) { [weak self] result in
      guard let self = self else { return }
      guard !self.offlineMode else {
        self.loadContactsFromBackup()
        return
      }
      switch result {
      case .success(let randomUserJSON):
        self.handleSuccessRequest(with: randomUserJSON)
      case .failure(let error):
        self.handleNetworkFailure(with: error)
      }
    }
  }

  private func handleSuccessRequest(with randomUserJson: RandomUserJSON) {
    if requestPage == 1 { coreDataManager.deleteAllObjects() }
    let contacts = randomUserJson.results.map { contactJson in
      Contact(contactJSON: contactJson)
    }
    coreDataManager.createNewObjects(contacts)

    delegate?.contactsManager(self, didReceive: contacts)
    requestPage += 1
  }

  private func handleNetworkFailure(with error: NetworkManagerError) {
    delegate?.contactsManager(self, didReceive: .networkError(error))
  }

  private func loadContactsFromBackup() {
    if !backupDataDidShow {
      let contacts = coreDataManager.fetchData().map { Contact(contactCoreData: $0) }
      delegate?.contactsManager(self, didReceive: contacts)
      delegate?.contactsManager(self, didReceive: .offlineModeEnabled)
      backupDataDidShow = true
    }
  }
}
