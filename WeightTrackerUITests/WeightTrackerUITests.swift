//
//  WeightTrackerUITests.swift
//  WeightTrackerUITests
//
//  Created by Swapnil Jain on 5/26/19.
//  Copyright © 2019 Swapnil Jain. All rights reserved.
//

import XCTest

class WeightTrackerUITests: XCTestCase {

  let app = XCUIApplication()
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false

    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    app.launch()

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testWeightListViewController() {
    // Verify title.
    XCTAssert(app.staticTexts["Weight Tracker"].exists)
    
    // Verify add operation.
    let numberOfRows = app.tables["table_view"].cells.count
    let addButton = app.navigationBars["Weight Tracker"].buttons["Add"]
    addButton.tap()
    addButton.tap()
    XCTAssertEqual(app.tables["table_view"].cells.count,
                   numberOfRows + 2)
    
    // Verify delete operation.
  }

}
