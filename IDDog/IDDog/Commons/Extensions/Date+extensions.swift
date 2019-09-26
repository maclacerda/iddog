//
//  Date+extensions.swift
//  IDDog
//
//  Created by Marcos Lacerda on 26/09/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import Foundation

extension Date {
  
  func diffDays(_ from: Date) -> Int {
    let calendar = Calendar.current

    let to = calendar.startOfDay(for: self)
    let fr = calendar.startOfDay(for: from)
    
    let components = calendar.dateComponents([.day], from: fr, to: to)
    
    return components.day ?? 0
  }
  
}
