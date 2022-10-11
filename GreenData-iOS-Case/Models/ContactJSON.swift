//
//  ContactJSON.swift
//  GreenData-iOS-Case
//
//  Created by Igor Buzykin on 11.10.2022.
//

import Foundation

struct ResultsJSON: Decodable {
  let results: [ContactJSON]
}

struct ContactJSON: Decodable {
  let gender: String
  let name: Name
  let location: Location
  let email: String
  let dob: Dob
  let phone: String
  let picture: Picture
}

struct Name: Decodable {
  let title: String
  let first: String
  let last: String
}

struct Picture: Decodable {
  let large: String
}

struct Dob: Decodable {
  let date: String
  let age: Int
}

struct Location: Decodable {
  let timezone: Timezone
}

struct Timezone: Decodable {
  let offset: String
  let description: String
}

extension ContactJSON: ContactRepresentable {
  var fullname: String { "\(name.first) \(name.last)" }
  var mail: String { email }
  var birthdayDate: String { dob.date }
  var birthdayAge: Int { dob.age }
  var localTime: String { location.timezone.offset }
  var picURL: String { picture.large }

  func generateMock() -> [ContactJSON] {
    [
      ContactJSON(
        gender: "female",
        name: Name(title: "mrs", first: "Karen1", last: "Jackson1"),
        location: Location(
          timezone: Timezone(offset: "+6:00", description: "Almaty, Dhaka, Colombo")
        ),
        email: "karen1@gmail.com",
        dob: Dob(date: "3221-33-12", age: 30),
        phone: "8 800 555 35 35",
        picture: Picture(large: "https://i.stack.imgur.com/yZlqh.png")
      ),
      ContactJSON(
        gender: "female",
        name: Name(title: "mrs", first: "Karen2", last: "Jackson2"),
        location: Location(
          timezone: Timezone(offset: "+6:00", description: "Almaty, Dhaka, Colombo")
        ),
        email: "karen1@gmail.com",
        dob: Dob(date: "3221-33-12", age: 30),
        phone: "8 800 555 35 35",
        picture: Picture(large: "https://i.stack.imgur.com/yZlqh.png")
      ),
      ContactJSON(
        gender: "female",
        name: Name(title: "mrs", first: "Karen3", last: "Jackson3"),
        location: Location(
          timezone: Timezone(offset: "+6:00", description: "Almaty, Dhaka, Colombo")
        ),
        email: "karen1@gmail.com",
        dob: Dob(date: "3221-33-12", age: 30),
        phone: "8 800 555 35 35",
        picture: Picture(large: "https://i.stack.imgur.com/yZlqh.png")
      )
    ]
  }
}
