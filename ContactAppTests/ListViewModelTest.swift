//
//  ListViewModelTest.swift
//  ContactAppTests
//
//  Created by Kamalesh Kumar Yadav on 16/06/20.
//  Copyright © 2020 Kamalesh Kumar Yadav. All rights reserved.
//

import XCTest
@testable import ContactApp

class ListViewModelTest: XCTestCase {

    var viewModel : ListViewModel!
    var dataSource : GenericDataSource<Contact>!
    fileprivate var service : MockcontactService!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.service = MockcontactService()
        self.dataSource = GenericDataSource<Contact>()
        self.viewModel = ListViewModel(service: service , dataSource: dataSource)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.viewModel = nil
        self.dataSource = nil
        self.service = nil
        super.tearDown()
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

    func testFetchWithNoService() {
        
        let expectation = XCTestExpectation(description: "No service List")
        
        // giving no service to a view model
        viewModel.service = nil
        
        // expected to not be able to fetch Facts
        viewModel.onErrorHandling = { error in
            expectation.fulfill()
        }
        
        viewModel.fetchList()
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchContact() {
        
        let expectation = XCTestExpectation(description: "Facts fetched")
        
        // giving a service mocking contacts
        service.facts = Contacts(success: 1, msg: "fetched data", data: [])
        
        viewModel.onErrorHandling = { _ in
            XCTAssert(false, "ViewModel should not be able to fetch without service")
        }
        
        dataSource.data.addObserver(self) { _ in
            expectation.fulfill()
        }
        
        viewModel.fetchList()
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchNoContacts() {
        
        let expectation = XCTestExpectation(description: "No contacts")
        
        // giving a service mocking error during fetching contacts
        service.facts = nil
        
        // expected completion to fail
        viewModel.onErrorHandling = { error in
            expectation.fulfill()
        }
        
        viewModel.fetchList()
        wait(for: [expectation], timeout: 5.0)
    }
}



fileprivate class MockcontactService : ContactServiceProtocol {
    var facts : Contacts?
    func fetchContactList(_ completion: @escaping ((Result<Contacts, ErrorResult>) -> Void)) {
        
        if let fact = facts {
            completion(Result.success(fact))
        } else {
            completion(Result.failure(ErrorResult.custom(string: "No contacts")))
        }
    }
}
