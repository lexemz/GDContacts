//
//  NetworkManager.swift
//  GreenData-iOS-Case
//
//  Created by Igor Buzykin on 11.10.2022.
//

import Foundation

class NetworkManager {
  static let shared = NetworkManager()
  
  private let urlAPI = "https://randomuser.me/api/?results=100"
  
  private init() {}
  
  func fetch<T: Decodable>(
    _ type: T.Type,
    with parameters: [String: String] = [:],
    completion: @escaping (Result<T, NetworkManagerError>) -> Void
  ) {
    guard var urlWithComponents = URLComponents(string: urlAPI) else {
      completion(.failure(.invalidURL))
      return
    }
    urlWithComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
      
    guard let url = urlWithComponents.url else {
      completion(.failure(.invalidURL))
      return
    }

    URLSession.shared.dataTask(with: url) { data, responce, error in
      guard let data = data else {
        completion(.failure(.transportError(error)))
        return
      }
      
      if let responce = responce as? HTTPURLResponse {
        guard (200 ... 299).contains(responce.statusCode) else {
          completion(.failure(.serverSideError(responce.statusCode)))
          return
        }
      }

      do {
        let decodeResult = try JSONDecoder().decode(T.self, from: data)
        completion(.success(decodeResult))
      } catch {
        completion(.failure(.decodeError(error)))
      }
    }.resume()
  }
}