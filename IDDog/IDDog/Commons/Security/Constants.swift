//
//  Constants.swift
//  IDDog
//
//  Created by Marcos Lacerda on 25/09/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import Foundation

struct Constants {
  
  /// The above string is used to generate the salt constant
  /// "IDWall-Challenge@2019"
  static let kSalt: [UInt8] = [73, 68, 87, 97, 108, 108, 45, 67, 104, 97, 108, 108, 101, 110, 103, 101, 64, 50, 48, 49, 57]
  
  static let kBaseURL: [UInt8] = [33, 48, 35, 17, 31, 86, 2, 108, 9, 17, 5, 65, 12, 10, 3, 10, 39, 28, 89, 85, 78, 40, 40, 59, 79, 15, 3]
  
}
