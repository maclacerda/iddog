//
//  FeedCollectionViewCell.swift
//  IDDog
//
//  Created by Marcos Lacerda on 26/09/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import UIKit
import Kingfisher

class FeedCollectionViewCell: UICollectionViewCell {
  
  // MARK: - Outlets
  
  @IBOutlet weak fileprivate var imageView: UIImageView!
  
  override func prepareForReuse() {
    super.prepareForReuse()
    imageView.image = nil
  }

  func setup(with item: String) {
    guard let url = URL(string: item) else { return }
    imageView.kf.setImage(with: url)
  }
  
}
