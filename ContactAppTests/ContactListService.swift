//
//  ContactListService.swift
//  ContactAppTests
//
//  Created by Kamalesh Kumar Yadav on 16/06/20.
//  Copyright © 2020 Kamalesh Kumar Yadav. All rights reserved.
//

import XCTest
@testable import ContactApp

class ContactListServiceModel: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testCancelRequest() {
        
        // giving a "previous" session
        ContactListService.shared.fetchContactList{ (_) in
            // ignore call
        }
        // Expected to task nil after cancel
        ContactListService.shared.cancelFetchCurrencies()
        XCTAssertNil(ContactListService.shared.task, "Expected task nil")
    }

}
