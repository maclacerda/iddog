//
//  ApplicationCoordinator.swift
//  IDDog
//
//  Created by Marcos Lacerda on 25/09/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import UIKit

class ApplicationCoordinator {
  
  let window: UIWindow
  let rootViewController: UINavigationController
  
  fileprivate let loginCoordinator: LoginCoordinator
  
  init(window: UIWindow) {
    self.window = window
    rootViewController = UINavigationController()

    if #available(iOS 11.0, *) {
      rootViewController.navigationBar.prefersLargeTitles = true
    }
    
    // Start login flow
    loginCoordinator = LoginCoordinator(presenter: rootViewController)
  }
  
  fileprivate func loginFlow() {
    loginCoordinator.start()
  }
  
}

extension ApplicationCoordinator: Coordinator {
  
  func start() {
    window.rootViewController = rootViewController
    window.makeKeyAndVisible()
    
    // Show the login screen
    self.loginFlow()
  }
  
}
