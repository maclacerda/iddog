//
//  BaseViewController.swift
//  IDDog
//
//  Created by Marcos Lacerda on 25/09/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import UIKit

// MARK: - Alert handler

typealias AlertCallback = (() -> Void)

class BaseViewController: UIViewController {
  
  // MARK: - Public properties
  
  var statusBarStyle: UIStatusBarStyle = .default {
    didSet {
      self.setNeedsStatusBarAppearanceUpdate()
    }
  }
  
  var statusBarHidden: Bool = true {
    didSet {
      self.setNeedsStatusBarAppearanceUpdate()
    }
  }
  
  // MARK: - Private properties
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return statusBarStyle
  }
  
  override var prefersStatusBarHidden: Bool {
    return statusBarHidden
  }
  
  override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
    return .fade
  }
  
  internal lazy var hud: CustomHUD = {
    return CustomHUD()
  }()
  
 // MARK: - Keyboard handler

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
  
  // MARK: - Public methods
  
  func showErrorMessage(_ message: String, withTryAgainButton: Bool = false, tryAgainCallback: AlertCallback? = nil, callback: AlertCallback? = nil) {
    let alert = UIAlertController(title: "Ops!", message: message, preferredStyle: .alert)

    let closeAction = UIAlertAction(title: "close".localized(), style: .cancel, handler: { _ in
      guard let handler = callback else {
        return
      }
      handler()
    })
    
    alert.addAction(closeAction)
    
    if withTryAgainButton {
      let tryAgainAction = UIAlertAction(title: "try-again".localized(), style: .default) { _ in
        guard let handler = tryAgainCallback else { return }
        handler()
      }

      alert.addAction(tryAgainAction)
    }

    self.present(alert, animated: true, completion: nil)
  }
  
  func showHUD() {
    hud.show(in: self.view)
  }
  
  func hideHUD() {
    hud.hide()
  }
  
}
