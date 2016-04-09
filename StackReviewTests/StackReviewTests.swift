//
//  StackReviewTests.swift
//  StackReviewTests
//
//  Created by Greg Heo on 2015-09-30.
//  Copyright © 2015 Razeware. All rights reserved.
//

import XCTest
@testable import StackReview

class StackReviewTests: XCTestCase {
  let collection = PancakeHouseCollection()

  override func setUp() {
    super.setUp()

    collection.loadTestData()
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }

    func testCloudLoadSucceeds() {
        class MockPancakeHouseCollection: PancakeHouseCollection {
            override var isCloudCollection: Bool {
                return true
            }
        }
        let collection = MockPancakeHouseCollection()
        let expectation = expectationWithDescription(
            "Expecting cloud data call to succeed!")
        collection.loadCloudTestData { (didReceiveData) -> () in
            if didReceiveData {
                expectation.fulfill()
            } else {
                XCTFail("Cloud data call failed!")
            }
        }
        waitForExpectationsWithTimeout(3, handler: nil)
    }
    
    func testCloudLoadFails() {
        let expectation = expectationWithDescription("Expecting cloud data call to fail")
        
        collection.loadCloudTestData { (didReceiveData) -> () in
            if didReceiveData {
                XCTFail()
            } else {
                expectation.fulfill()
            }
        }
            waitForExpectationsWithTimeout(3, handler: nil)
    }
    
  func testCollectionHasItems() {
    XCTAssertGreaterThan(collection.count, 0, "Collection didn't have at least one item!")
  }

  func testAdd() {
    let pancakeData = ["name": "Test Pancake House", "priceGuide": 1, "rating": 1, "details": "Test"]
    let samplePancakeHouse = PancakeHouse(dict: pancakeData)!
    let startCount = collection.count

    collection.addPancakeHouse(samplePancakeHouse)
    XCTAssertEqual(collection.count, startCount + 1)
  }

  func testRemove() {
    let startCount = collection.count
    let pancakeHouseToRemove = collection[0]

    collection.removePancakeHouse(pancakeHouseToRemove)
    XCTAssertEqual(collection.count, startCount - 1)
  }

}
