//
//  LoginCoordinator.swift
//  IDDog
//
//  Created by Marcos Lacerda on 25/09/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import UIKit

class LoginCoordinator {
  
  private let presenter: UINavigationController
  private var loginController: LoginViewController
  
  init(presenter: UINavigationController) {
    self.presenter = presenter
    self.loginController = LoginViewController()
  }
  
}

extension LoginCoordinator: Coordinator {
  
  func start() {
    loginController.title = "login".localized()
    
    presenter.pushViewController(loginController, animated: true)
  }
  
}
