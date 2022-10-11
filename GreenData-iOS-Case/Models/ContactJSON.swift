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
    let email: String
    let phone: String
    let picture: Picture
}

struct Name: Decodable {
    let title: String
    let first: String
    let last: String
    
    var fullName: String {
        "\(first) \(last)"
    }
}

struct Picture: Decodable {
    let large: String
}
