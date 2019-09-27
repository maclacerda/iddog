//
//  FeedViewModel.swift
//  IDDog
//
//  Created by Marcos Lacerda on 26/09/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import Foundation

protocol FeedViewModelDelegate {
  func feedFetchedWithSuccess()
  func feedFetchedWithError(_ error: String)
}

struct FeedViewModel {
  
  fileprivate let delegate: FeedViewModelDelegate!
  fileprivate let datasource: FeedDatasource!
  
  // MARK: - Life cycle
  
  init(with delegate: FeedViewModelDelegate, datasource: FeedDatasource) {
    self.delegate = delegate
    self.datasource = datasource
  }
  
  // MARK: - Public methods
  
  func fetchFeed(_ category: FeedCategories = .husky) {
    FeedServices.shared.fetchFeed(category) { result in
      switch result {
      case .success(let pets): self.success(pets)
      case .error(let error): self.error(error)
      }
    }
  }
  
  func fetchFeed(by category: FeedCategories) {
    self.fetchFeed(category)
  }
  

  // MARK: - Private methods
  
  fileprivate func success(_ pets: Pets) {
    guard let delegate = self.delegate else {
      fatalError("FeedViewModelDelegate not assigned yet.")
    }
    
    // Update datasource to resultset
    datasource.pets = pets
    
    // Notify the screen
    delegate.feedFetchedWithSuccess()
  }
  
  fileprivate func error(_ error: String) {
    guard let delegate = self.delegate else {
      fatalError("FeedViewModelDelegate not assigned yet.")
    }

    delegate.feedFetchedWithError(error)
  }
  
}
