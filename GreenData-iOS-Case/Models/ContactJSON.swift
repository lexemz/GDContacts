//
//  ContactJSON.swift
//  GreenData-iOS-Case
//
//  Created by Igor Buzykin on 11.10.2022.
//

import Foundation

struct RandomUserJSON: Decodable {
  let results: [ContactJSON]
  let info: Info
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

struct Info: Decodable {
  let page: Int
}
