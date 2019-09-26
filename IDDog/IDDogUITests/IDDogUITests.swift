//
//  IDDogUITests.swift
//  IDDogUITests
//
//  Created by Marcos Lacerda on 25/09/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import XCTest

class IDDogUITests: XCTestCase {
  
  var app = XCUIApplication()

  override func setUp() {
    super.setUp()
    
    continueAfterFailure = false
    app.launch()
  }

  override func tearDown() {
    super.tearDown()
  }
  
  func testMailFieldExistsInLoginScreen() {
    let mailField = app.textFields["E-mail"]

    XCTAssertTrue(mailField.exists, "Should be in the login screen")
  }

}
