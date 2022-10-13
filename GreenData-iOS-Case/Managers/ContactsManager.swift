//
//  ContactsManager.swift
//  GreenData-iOS-Case
//
//  Created by Igor Buzykin on 11.10.2022.
//

import Foundation

protocol ContactsManagerDelegate: AnyObject {
  func contactsManager(
    _ contactsManager: ContactsManager,
    didReceive contacts: [ContactRepresentable]
  )
  func contactsManager(
    _ contactsManager: ContactsManager,
    didReceive event: ContactManagerEvents
  )
}

enum ContactManagerEvents {
    case networkError
}

final class ContactsManager {
  var delegate: ContactsManagerDelegate?

  private let networkManager = NetworkManager.shared
  private var requestPage = 1

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
      switch result {
      case .success(let randomUserJSON):
        self.handleSuccessRequest(with: randomUserJSON)
      case .failure(let error):
        Log.e(error)
        self.delegate?.contactsManager(self, didReceive: .networkError)
      }
    }
  }
  
  private func handleSuccessRequest(with randomUserJson: RandomUserJSON) {
    Log.d("Получены контакты: page = \(randomUserJson.info.page)")
    let contacts = randomUserJson.results.map { $0 }
    delegate?.contactsManager(self, didReceive: contacts)
    self.requestPage += 1
  }
}
