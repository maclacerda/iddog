//
//  LoginViewModel.swift
//  IDDog
//
//  Created by Marcos Lacerda on 25/09/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import Foundation

protocol LoginViewModelDelegate {
  func signInSuccess()
  func signInError(_ error: String)
}

struct LoginViewModel {
  
  fileprivate let delegate: LoginViewModelDelegate!
  
  // MARK: - Life cycle
  
  init(with delegate: LoginViewModelDelegate) {
    self.delegate = delegate
  }
  
  // MARK: - Public methods
  
  func performLogin(_ email: String) {
    LoginServices.shared.performLogin(email) { result in
      switch result {
      case .success(let user): self.success(user)
      case .error(let error): self.error(error)
      }
    }
  }
  
  // MARK: - Private methods
  
  fileprivate func success(_ user: User) {
    guard let delegate = self.delegate else {
      fatalError("LoginViewModelDelegate not assigned yet.")
    }
    
    // Store the user credentials in "Session Model"
    ApplicationSession.loggedUser = user

    // Notify the screen
    delegate.signInSuccess()
  }
  
  fileprivate func error(_ error: String) {
    guard let delegate = self.delegate else {
      fatalError("LoginViewModelDelegate not assigned yet.")
    }

    delegate.signInError(error)
  }
  
}
