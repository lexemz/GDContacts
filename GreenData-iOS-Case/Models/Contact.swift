//
//  Contact.swift
//  GreenData-iOS-Case
//
//  Created by Igor Buzykin on 13.10.2022.
//

import Foundation

struct Contact {
  let fullname: String
  let gender: ContactGender
  let mail: String
  let birthdayDate: String
  let birthdayAge: Int
  let localTimeOffset: String
  let picURL: String
  let phoneNumber: String
  
  init(
    fullname: String,
    gender: String,
    mail: String,
    birthdayDate: String,
    birthdayAge: Int,
    localTimeOffset: String,
    picURL: String,
    phoneNumber: String
  ) {
    self.fullname = fullname
    self.mail = mail
    self.birthdayDate = birthdayDate
    self.birthdayAge = birthdayAge
    self.localTimeOffset = localTimeOffset
    self.picURL = picURL
    self.phoneNumber = phoneNumber
    
    switch gender {
    case "male": self.gender = .male
    case "female": self.gender = .female
    default: self.gender = .unknown
    }
  }
  
  init(contactJSON contact: ContactJSON) {
    self.init(
      fullname: "\(contact.name.first) \(contact.name.last)",
      gender: contact.gender,
      mail: contact.email,
      birthdayDate: contact.dob.date,
      birthdayAge: contact.dob.age,
      localTimeOffset: contact.location.timezone.offset,
      picURL: contact.picture.large,
      phoneNumber: contact.phone
    )
  }
  
  init(contactCoreData contact: ContactCoreData) {
    self.init(
      fullname: contact.fullname ?? "",
      gender: contact.gender ?? "",
      mail: contact.mail ?? "",
      birthdayDate: contact.birthdayDate ?? "",
      birthdayAge: Int(contact.birthdayAge),
      localTimeOffset: contact.localTimeOffset ?? "",
      picURL: contact.picURL ?? "",
      phoneNumber: contact.phoneNumber ?? ""
    )
  }
}

enum ContactGender: String {
  case male = "Мужчина"
  case female = "Женщина"
  case unknown = "Неизвестно"
}
