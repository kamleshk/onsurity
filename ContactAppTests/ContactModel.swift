//
//  ContactModel.swift
//  ContactAppTests
//
//  Created by Kamalesh Kumar Yadav on 16/06/20.
//  Copyright © 2020 Kamalesh Kumar Yadav. All rights reserved.
//

import XCTest
@testable import ContactApp
class ContactModel: XCTestCase {

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
    
    func testParseEmptyFacts() {
        
        // giving empty data
        let data = Data()
        
        // giving completion after parsing
        let completion: ((Result<Contacts, ErrorResult>) -> Void) = { result in
            switch result {
            case .success(_):
                XCTAssert(false, "Expected failure when no data")
            default:
                break
            }
        }
        
        ParserHelper.parse(data: data, completion: completion)
    }
    
    func testParseFacts() {
        
        // giving a sample json file
        guard let data = FileManager.readJson(forResource: "sample") else {
            XCTAssert(false, "Can't get data from sample.json")
            return
        }
        
        // giving completion after parsing
        let completion : ((Result<Contacts, ErrorResult>) -> Void) = { result in
            switch result {
            case .failure(_):
                XCTAssert(false, "Expected valid Facts")
            case .success(let contact):
                XCTAssertEqual(contact.data?.first?.first_name, "TestUser", "Expected TestUser")
                XCTAssertEqual(contact.data?.count, 7, "Expected 7")
            }
        }
        
        ParserHelper.parse(data: data, completion: completion)
    }
    
    

}
