//
//  UserDefaults+extensions.swift
//  IDDog
//
//  Created by Marcos Lacerda on 27/09/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import Foundation

extension UserDefaults {
  
  class func read(key: String) -> Any? {
    return UserDefaults.standard.value(forKey: key)
  }
  
  class func write(value: Any, in key: String) {
    UserDefaults.standard.set(value, forKey: key)
    UserDefaults.standard.synchronize()
  }
  
}
