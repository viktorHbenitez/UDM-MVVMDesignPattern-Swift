//
//  Webservice.swift
//  HotCoffee
//
//  Created by Mohammad Azam on 5/11/19.
//  Copyright © 2019 Mohammad Azam. All rights reserved.
//

import Foundation

enum NetworkError: Error {
  case decodingError
  case domainError
  case urlError
}

struct Resource<T: Codable> {
  let url: URL
}

class Webservice {
  
  func load<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void) {
    
    // fetch data
    URLSession.shared.dataTask(with: resource.url) { data, response, error in
      
      guard let data = data, error == nil else {
        completion(.failure(.domainError))
        return
      }
      // decoder the response
      let result = try? JSONDecoder().decode(T.self, from: data)
      if let result = result {
        DispatchQueue.main.async {
          completion(.success(result))
        }
      }
      else {
        DispatchQueue.main.async {
          completion(.failure(.decodingError))
        }
      }
      
    }.resume()
    
  }
  
}
