//
//  SecurityManager.swift
//  IDDog
//
//  Created by Marcos Lacerda on 25/09/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import Foundation
import KeychainSwift

class SecurityManager: NSObject {
  
  static let shared = SecurityManager()
  
  fileprivate let obfuscator = Obfuscator()
  fileprivate let keychain = KeychainSwift()
  
  override internal init() {}
  
  func reveal(_ key: [UInt8]) -> String {
    return obfuscator.reveal(key: key)
  }
  
  // MARK: - Keychain handler
  
  func save(value: String, key: String) {
    keychain.set(value, forKey: key)
  }
  
  func load(in key: String) -> String {
    return keychain.get(key) ?? ""
  }
  
  func remove(in key: String) {
    keychain.delete(key)
  }

}
