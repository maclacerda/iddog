//
//  Commoms.swift
//  IDDog
//
//  Created by Marcos Lacerda on 25/09/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import Foundation

enum ViewState {
  
  case normal
  case loading
  case error
  
}

enum Result<Value> {
  
  case success(Value)
  case error(String)
  
}
