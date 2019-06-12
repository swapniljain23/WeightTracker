//
//  WeightTrackerTests.swift
//  WeightTrackerTests
//
//  Created by Swapnil Jain on 5/26/19.
//  Copyright © 2019 Swapnil Jain. All rights reserved.
//

import XCTest
@testable import WeightTracker

class WeightTrackerTests: XCTestCase {

  override func setUp() {
      // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDown() {
      // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testWeightListViewModel() {
    let viewModel = WeightListViewModel(persistentManager: PersistentManager())
    let entryCount = viewModel.items.count
    viewModel.addWeightEntry(entry: viewModel.randomWeightEntry())
    viewModel.addWeightEntry(entry: viewModel.randomWeightEntry())
    viewModel.loadPersistentWeightData()
    XCTAssertEqual(viewModel.items.count, entryCount+2)
    viewModel.removeWeightEntry(at: 0)
    XCTAssertEqual(viewModel.items.count, entryCount+1)
    viewModel.removeWeightEntry(at: -1)
    XCTAssertEqual(viewModel.items.count, entryCount+1)
  }

//  func testPerformanceExample() {
//      // This is an example of a performance test case.
//      self.measure {
//          // Put the code you want to measure the time of here.
//      }
//  }

}
