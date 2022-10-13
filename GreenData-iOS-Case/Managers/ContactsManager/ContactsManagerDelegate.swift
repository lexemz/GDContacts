//
//  ContactsManagerDelegate.swift
//  GreenData-iOS-Case
//
//  Created by Igor Buzykin on 13.10.2022.
//

import Foundation

protocol ContactsManagerDelegate: AnyObject {
  func contactsManager(
    _ contactsManager: ContactsManager,
    didReceive contacts: [Contact]
  )
  func contactsManager(
    _ contactsManager: ContactsManager,
    didReceive event: ContactManagerEvents
  )
}
