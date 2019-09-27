//
//  CustomHUD.swift
//  IDDog
//
//  Created by Marcos Lacerda on 25/09/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import UIKit

class CustomHUD: UIView {
  
  // MARK: - Public properties
  
  var borderColor: UIColor = .clear {
    didSet {
      self.layer.borderColor = borderColor.cgColor
    }
  }
  
  var borderWidth: CGFloat = 0.0 {
    didSet {
      self.layer.borderWidth = borderWidth
    }
  }
  
  var cornerRadius: CGFloat = 0.0 {
    didSet {
      self.layer.cornerRadius = cornerRadius
      self.layer.masksToBounds = true
    }
  }

  var size: CGSize = .zero
  
  // MARK: - Private properties
  
  internal lazy var activityIndicator: UIActivityIndicatorView = {
    let indicator: UIActivityIndicatorView

    if #available(iOS 13.0, *) {
      indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
      indicator.color = .white
    } else {
      indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
    }

    indicator.startAnimating()

    return indicator
  }()
  
  // MARK: - Initializers
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.commomInit()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.commomInit()
  }
  
  // MARK: - Private methods
  
  fileprivate func commomInit() {
    self.backgroundColor = UIColor.black.withAlphaComponent(0.8)

    self.borderWidth = 0.5
    self.borderColor = .white
    self.cornerRadius = 10.0
    
    self.size = CGSize(width: 100, height: 100)
  }

  // MARK: - Public methods
  
  func show(in view: UIView) {
    let screenBounds = UIScreen.main.bounds
    let x = (screenBounds.width - size.width) / 2
    let y = (screenBounds.height - size.height) / 2

    let origin: CGPoint = CGPoint(x: x, y: y)
    let frame = CGRect(origin: origin, size: size)

    self.frame = frame
    
    // Add indicator
    self.activityIndicator.center = view.center
    
    view.addSubview(self)
    view.addSubview(activityIndicator)
  }
  
  func hide() {
    self.removeFromSuperview()
  }
  
}
