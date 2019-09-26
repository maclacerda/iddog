//
//  FeedCoordinator.swift
//  IDDog
//
//  Created by Marcos Lacerda on 26/09/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import UIKit

class FeedCoordinator {
  
  private let presenter: UINavigationController
  private var feedController: FeedViewController
  
  init(presenter: UINavigationController) {
    self.presenter = presenter
    self.feedController = FeedViewController()
  }
  
}

extension FeedCoordinator: Coordinator {
  
  func start() {
    feedController.title = "Pets"
    
    presenter.viewControllers.removeAll()
    presenter.viewControllers.append(feedController)
  }
  
}
