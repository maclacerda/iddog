//
//  LoginCoordinator.swift
//  IDDog
//
//  Created by Marcos Lacerda on 25/09/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import UIKit

protocol LoginCoordinatorDelegate: class {
  func goToFeed()
}

class LoginCoordinator {
  
  private let presenter: UINavigationController
  private var loginController: LoginViewController
  
  weak var delegate: LoginCoordinatorDelegate?

  init(presenter: UINavigationController) {
    self.presenter = presenter
    self.loginController = LoginViewController()
  }
  
}

extension LoginCoordinator: Coordinator {
  
  func start() {
    loginController.title = "login".localized()
    loginController.delegate = delegate
    
    presenter.pushViewController(loginController, animated: true)
  }
  
}
