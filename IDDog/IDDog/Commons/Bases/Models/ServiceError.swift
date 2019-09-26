//
//  ServiceError.swift
//  IDDog
//
//  Created by Marcos Lacerda on 25/09/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import Foundation

struct ServiceError: Decodable {
  
  let error: ServiceMessageError
  
  fileprivate enum CodingKeys: String, CodingKey {
    case error
  }
  
}

internal struct ServiceMessageError: Decodable {
  
  let message: String
  
  fileprivate enum CodingKeys: String, CodingKey {
    case message
  }
  
}
