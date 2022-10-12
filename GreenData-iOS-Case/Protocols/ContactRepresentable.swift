//
//  ContactRepresentable.swift
//  GreenData-iOS-Case
//
//  Created by Igor Buzykin on 11.10.2022.
//

import Foundation

protocol ContactRepresentable {
  var fullname: String { get }
  var gender: String { get }
  var birthdayDate: String { get }
  var birthdayAge: Int { get }
  var mail: String { get }
  var localTimeOffset: String { get }
  var phoneNumber: String { get }
  
  var picURL: String { get }
  
  func generateMock() -> [Self]
}
