//
//  ApplicationCoordinator.swift
//  IDDog
//
//  Created by Marcos Lacerda on 25/09/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import UIKit

class ApplicationCoordinator {
  
  fileprivate let window: UIWindow
  fileprivate let rootViewController: UINavigationController
  
  fileprivate var childCoordinators = [Coordinator]()
  
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
    loginCoordinator.delegate = self
    loginCoordinator.start()

    childCoordinators.append(loginCoordinator)
  }

  fileprivate func feedFlow() {
    feedCoordinator.start()
    childCoordinators.append(feedCoordinator)
  }
  
  fileprivate func removeChild(coordinator: Coordinator) {
    self.childCoordinators = self.childCoordinators.filter {
      $0 !== coordinator
    }
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

extension ApplicationCoordinator: LoginCoordinatorDelegate {
  
  func goToFeed() {
    removeChild(coordinator: loginCoordinator)
    self.feedFlow()
  }
  
}
