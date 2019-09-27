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

  // MARK: - Login tests

  func testSignInUserShouldBeSucess() {
    let email = "markos.lacerda@gmail.com"
    let expectation = XCTestExpectation(description: "Sign in should be sucess")

    LoginServices.shared.performMockLogin(email) { result in
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
    
    LoginServices.shared.performMockLogin(email, shouldBeFail: true) { result in
      if case .error(let message) = result {
        XCTAssertEqual(message, "Email is not valid")
      } else {
        XCTFail()
      }
      
      expectation.fulfill()
    }

    wait(for: [expectation], timeout: timeout)
  }
  
  // MARK: - Feed tests
  
  func testLoadFeedWithCategorieHuskyShouldBeSuccess() {
    let expectation = XCTestExpectation(description: "Load 'husky' photos sucess")
    
    FeedServices.shared.fetchMockFeed(.husky) { result in
      if case .success(let pets) = result {
        XCTAssertNotNil(pets)
      } else {
        XCTFail()
      }

      expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: timeout)
  }
  
  func testLoadFeedWithCategorieLabradorShouldBeFail() {
    let expectation = XCTestExpectation(description: "Load 'labrador' photos fail")
    
    FeedServices.shared.fetchMockFeed(.labrador, shouldBeFail: true) { result in
      if case .error(let error) = result {
        XCTAssertEqual(error, "Feed not avaliable now")
      } else {
        XCTFail()
      }

      expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: timeout)
  }
  
  // MARK: - Security tests
  
  func testSecurityManagerRevealShouldBeSuccess() {
    let expectedResult = "https://api-iddog.idwall.co"
    let result = SecurityManager.shared.reveal(Constants.kBaseURL)
    
    XCTAssertEqual(result, expectedResult, "The revealed string not match to `\(expectedResult)`")
  }
  
  // MARK: - Extensions tests
  
  func testValidDiffBetweenTwoDatesShouldSucess() {
    let now = Date()
    let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: now)!
    let diff = tomorrow.diffDays(now)
    
    XCTAssertEqual(diff, 1)
  }
  
  func testTrimmedStringShouldSucess() {
    let text = ""

    XCTAssertTrue(text.trim().isEmpty)
  }
  
  func testValidEmailShouldFail() {
    let invalidEmail = "bla@@bla.com"
    
    XCTAssertFalse(invalidEmail.isValidEmail())
  }
  
  func testValidateUserDefaultsKeyNotExistsShouldSucess() {
    let key = "keyExists"
    
    XCTAssertNil(UserDefaults.read(key: key))
  }
  
  // MARK: - Security tests
  
  func testCheckGenerateSaltShouldSucess() {
    let genereatedSalt: [UInt8] = Obfuscator.generateSalt(with: "IDWall-Challenge@2019")
    let expectedSalt: [UInt8] = [73, 68, 87, 97, 108, 108, 45, 67, 104, 97, 108, 108, 101, 110, 103, 101, 64, 50, 48, 49, 57]
    
    XCTAssertEqual(genereatedSalt, expectedSalt)
  }

}
