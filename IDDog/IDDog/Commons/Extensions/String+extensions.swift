//
//  String+extensions.swift
//  IDDog
//
//  Created by Marcos Lacerda on 25/09/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import Foundation

extension String {
  
  func localized() -> String {
    return NSLocalizedString(self, comment: "")
  }
  
  func trim() -> String {
    return self.replacingOccurrences(of: " ", with: "")
  }
  
  func isValidEmail() -> Bool {
      let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

      let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)

      return emailTest.evaluate(with: self)
  }
  
}
