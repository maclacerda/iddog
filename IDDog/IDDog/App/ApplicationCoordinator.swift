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
  fileprivate let feedCoordinator: FeedCoordinator
  
  init(window: UIWindow) {
    self.window = window
    rootViewController = UINavigationController()

    if #available(iOS 11.0, *) {
      rootViewController.navigationBar.prefersLargeTitles = true
    }
    
    // Try restore previous user session
    ApplicationSession.loadSession()
    
    // Start login flow
    loginCoordinator = LoginCoordinator(presenter: rootViewController)
    
    // Start feed flow
    feedCoordinator = FeedCoordinator(presenter: rootViewController)
  }
  
  fileprivate func loginFlow() {
    loginCoordinator.start()
  }

  fileprivate func feedFlow() {
    feedCoordinator.start()
  }
  
}

extension ApplicationCoordinator: Coordinator {
  
  func start() {
    window.rootViewController = rootViewController
    window.makeKeyAndVisible()
    
    // Check if user has a valid session
    if ApplicationSession.isValideSession() {
      // Show the feed screen
      self.feedFlow()
    } else {
      // Show the login screen
      self.loginFlow()
    }
  }
  
}
