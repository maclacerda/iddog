//
//  FeedDatasource.swift
//  IDDog
//
//  Created by Marcos Lacerda on 26/09/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import UIKit

class FeedDatasource: NSObject, UICollectionViewDataSource {
  
  var pets: Pets? {
    didSet {
      items.removeAll()
      items.append(contentsOf: pets!.list)
    }
  }
  
  internal var items = [String]()
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCell", for: indexPath) as? FeedCollectionViewCell else {
      return UICollectionViewCell()
    }
    
    cell.setup(with: items[indexPath.row])
    
    return cell
  }
  
  // MARK: - Commom methods
  
  func givePhoto(at index: IndexPath) -> String {
    return items[index.row]
  }

}
