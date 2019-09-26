//
//  LoginViewController.swift
//  IDDog
//
//  Created by Marcos Lacerda on 25/09/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {
  
  // MARK: - Outlets
  
  @IBOutlet weak fileprivate var mailField: UITextField!
  @IBOutlet weak fileprivate var signinButton: UIButton!
  
  // MARK: - Private properties
  
  fileprivate var state: ViewState = .normal {
    didSet {
      self.setupView()
    }
  }
  
  fileprivate var viewModel: LoginViewModel!
  
  // MARK: - Initializers
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    
    self.viewModel = LoginViewModel(with: self)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    self.viewModel = LoginViewModel(with: self)
  }
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.initUI()
    self.initI18N()
  }

  // MARK: - Private methods
  
  fileprivate func initUI() {
    self.statusBarHidden = false
  }
  
  fileprivate func setupView() {
    switch state {
    case .loading: self.showHUD()
    default: self.hideHUD()
    }
  }
  
  fileprivate func initI18N() {
    signinButton.setTitle("signin".localized(), for: .normal)
  }
  
  // MARK: - Actions
  
  @IBAction fileprivate func signInButtonClick() {
    // Close keyboard
    mailField.endEditing(true)

    // Validating if user inputed a valid email
    if !validateFields() {
      self.invalidUserCredentials()
      return
    }

    // Perform login
    guard let email = mailField.text else { return }

    self.state = .loading
    viewModel.performLogin(email)
  }
  
  fileprivate func validateFields() -> Bool {
    guard let credential = mailField.text else {
      return false
    }
    
    return credential.isValidEmail()
  }
  
  fileprivate func invalidUserCredentials() {
    self.showErrorMessage("user-credentials-invalid".localized(), callback: {
      self.mailField.becomeFirstResponder()
    })
  }
  
}

extension LoginViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    // Send sigin action
    self.signInButtonClick()
    
    return true
  }
  
}

extension LoginViewController: LoginViewModelDelegate {
  
  func signInSuccess() {
    self.state = .normal
    print("Success")
  }
  
  func signInError(_ error: String) {
    self.state = .error

    self.showErrorMessage(error, callback: {
      self.mailField.becomeFirstResponder()
    })
  }
  
}
