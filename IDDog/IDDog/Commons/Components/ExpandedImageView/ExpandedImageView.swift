//
//  ExpandedImageView.swift
//  IDDog
//
//  Created by Marcos Lacerda on 26/09/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import UIKit
import SDWebImage

class ExpandedImageView: UIView {
  
  fileprivate var imageView = UIImageView(frame: .zero)
  
  var dismissOnTap: Bool = false {
    didSet {
      // Dismiss handler
      let tap = UITapGestureRecognizer(target: self, action: #selector(dismissAction))
      
      self.isUserInteractionEnabled = true
      self.addGestureRecognizer(tap)
    }
  }

  // MARK: - Initializers
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.commomInit()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.commomInit()
  }
  
  // MARK: - Commom
  
  fileprivate func commomInit() {
    self.backgroundColor = UIColor.black.withAlphaComponent(0.40)
    self.makeImageView()
  }
  
  fileprivate func makeImageView() {
    imageView.backgroundColor = .clear
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.isUserInteractionEnabled = false
    imageView.frame = CGRect(x: 0, y: 0, width: self.bounds.width - 16, height: self.bounds.width - 16)
    
    imageView.center = self.center

    self.addSubview(imageView)
    self.bringSubviewToFront(imageView)
  }
  
  // MARK: - Actions
  
  @objc fileprivate func dismissAction() {
    UIView.transition(with: self, duration: 0.25, options: [.transitionCrossDissolve], animations: {
      self.removeFromSuperview()
    }, completion: nil)
  }
  
  func show(with image: String) {
    guard let url = URL(string: image) else { return }
    imageView.sd_setImage(with: url)
  }
  
}
