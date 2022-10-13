//
//  NetworkManagerError.swift
//  GreenData-iOS-Case
//
//  Created by Igor Buzykin on 13.10.2022.
//

import Foundation

enum NetworkManagerError: Error, LocalizedError {
  case invalidURL
  case transportError(Error?)
  case decodeError(Error?)
  case serverSideError(Int)
  
  var errorDescription: String? {
      switch self {
      case .invalidURL:
          return "Invalid URL in dataTask"
      case .transportError(let error):
          return error?.localizedDescription
      case .decodeError(let error):
          return error?.localizedDescription
      case .serverSideError(let code):
          return "Server Side Error - code: \(code)"
      }
  }
}
