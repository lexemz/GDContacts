//
//  ContactsManager.swift
//  GreenData-iOS-Case
//
//  Created by Igor Buzykin on 11.10.2022.
//

import Foundation

protocol ContactsManagerDelegate: AnyObject {
  func handle(_ from: ContactsManager, receivedContacts: [ContactRepresentable])
  func handle(_ from: ContactsManager, receivedError: NetworkManagerError)
}

final class ContactsManager {
  var delegate: ContactsManagerDelegate?

  private let networkManager = NetworkManager.shared
  private var requestPage = 1

  func startFetchContacts() {
    networkManager.fetchContacts(
      parameters: [
        "page": "\(requestPage)",
        "results": "10",
        "seed": "lexemz.seed"
      ]
    ) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let contacts):
        self.delegate?.handle(self, receivedContacts: contacts)
        Log.d("Получены контакты: page = \(self.requestPage)")
        self.requestPage += 1
      case .failure(let error):
        self.delegate?.handle(self, receivedError: error)
      }
    }
  }
}
