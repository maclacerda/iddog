//
//  ApplicationSession.swift
//  IDDog
//
//  Created by Marcos Lacerda on 25/09/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import Foundation

struct ApplicationSession {
  
  internal static let kUserDataKey = "user-data"
  
  static var loggedUser: User!
  
  static func saveSession() {
    // Store the user credentials in keychain
    SecurityManager.shared.save(value: loggedUser.toJSON(), key: kUserDataKey)
  }
  
  static func loadSession() {
    let json = SecurityManager.shared.load(in: kUserDataKey)

    if !json.isEmpty {
      loggedUser = try? JSONDecoder().decode(User.self, from: json.data(using: .utf8) ?? Data())
    }
  }
  
  static func clearSession() {
    SecurityManager.shared.remove(in: kUserDataKey)
  }
  
  static func isValideSession() -> Bool {
    return loggedUser != nil
    
    /// A ideia inicial era criar um mecanismo para "checar" se o token ainda estava valido
    /// Entretanto, a API retorna sempre a mesma data nos atributos "createdAt" e "updatedAt"
    /// mesmo que eu faço enumeras tentativas de login
    /// inviabilizando assim a minha ideia original.

    /*
    guard let user = loggedUser else {
      return false
    }

    let signInDate = user.lastRefresh
    let now = Date()
    let diff = now.diffDays(signInDate)

    return diff == 0
    */
  }
  
}
