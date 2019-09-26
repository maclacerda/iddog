//
//  Pets.swift
//  IDDog
//
//  Created by Marcos Lacerda on 26/09/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import Foundation

struct Pets: Decodable {
  
  let list: [String]
  
  fileprivate enum CodingKeys: String, CodingKey {
    case list
  }
  
}
