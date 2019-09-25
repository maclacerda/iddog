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
  
  init(window: UIWindow) {
    self.window = window
    rootViewController = UINavigationController()

    if #available(iOS 11.0, *) {
      rootViewController.navigationBar.prefersLargeTitles = true
    }
    
    // Define the flow executed
    self.loginFlow()
  }
  
  fileprivate func loginFlow() {
    let vc = UIViewController()
    vc.view.backgroundColor = .white
    rootViewController.pushViewController(vc, animated: false)
  }
  
}

extension ApplicationCoordinator: Coordinator {
  
  func start() {
    window.rootViewController = rootViewController
    window.makeKeyAndVisible()
  }
  
}
