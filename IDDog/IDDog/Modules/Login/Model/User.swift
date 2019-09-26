//
//  User.swift
//  IDDog
//
//  Created by Marcos Lacerda on 25/09/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import Foundation

struct User: Decodable {
  
  let token: String
  
  fileprivate enum CodingKeys: String, CodingKey {
    case token
  }
  
}
