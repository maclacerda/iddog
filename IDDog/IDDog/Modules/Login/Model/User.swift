//
//  User.swift
//  IDDog
//
//  Created by Marcos Lacerda on 25/09/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import Foundation

struct User: Codable {
  
  let id: String
  let token: String
  let lastRefresh: Date
  
  fileprivate enum CodingKeys: String, CodingKey {
    case id = "_id"
    case token
    case lastRefresh = "updatedAt"
  }
  
}


extension User {
  
  func toJSON() -> String {
    let encoder = JSONEncoder()
    
    guard let data = try? encoder.encode(self), let json = String(data: data, encoding: .utf8) else {
      return ""
    }

    return json
  }
  
}
