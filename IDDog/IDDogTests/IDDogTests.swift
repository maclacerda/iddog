//
//  IDDogTests.swift
//  IDDogTests
//
//  Created by Marcos Lacerda on 24/09/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import XCTest
@testable import IDDog

class IDDogTests: XCTestCase {
  
  private let timeout: TimeInterval = 3.0
  private var viewModelExpectation: XCTestExpectation!

  override func setUp() {}
  override func tearDown() {}

  func testSignInUserShouldBeSucess() {
    let email = "markos.lacerda@gmail.com"
    let expectation = XCTestExpectation(description: "Sign in should be sucess")

    LoginServices.shared.performLogin(email) { result in
      if case .success(let user) = result {
        XCTAssertNotNil(user)
      } else {
        XCTFail()
      }

      expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: timeout)
  }
  
  func testSignInShouldBeFail() {
    let email = "blablabla"
    let expectation = XCTestExpectation(description: "Sign in should be fail")
    
    LoginServices.shared.performLogin(email) { result in
      if case .error(let message) = result {
        XCTAssertEqual(message, "Email is not valid")
      } else {
        XCTFail()
      }
      
      expectation.fulfill()
    }

    wait(for: [expectation], timeout: timeout)
  }
  
  func testViewModelPerformLoginShouldSuccess() {
    let email = "markos.lacerda@gmail.com"
    let viewModel = LoginViewModel(with: self)
    viewModelExpectation = XCTestExpectation(description: "Sign in with viewModel should be sucess")
    
    viewModel.performLogin(email)

    wait(for: [viewModelExpectation], timeout: timeout)
  }
  
  func testViewModelPerfomLoginShouldFail() {
    let email = "blalbabla"
    let viewModel = LoginViewModel(with: self)
    viewModelExpectation = XCTestExpectation(description: "Sign in with viewModel should be fail")
    
    viewModel.performLogin(email)

    wait(for: [viewModelExpectation], timeout: timeout)
  }

}

extension IDDogTests: LoginViewModelDelegate {
  
  func signInSuccess() {
    print("ViewModel login success")
    viewModelExpectation.fulfill()
  }
  
  func signInError(_ error: String) {
    print("ViewModel login failure: \(error)")
    viewModelExpectation.fulfill()
  }
  
}
