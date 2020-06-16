//
//  ListDataSourceTest.swift
//  ContactAppTests
//
//  Created by Kamalesh Kumar Yadav on 16/06/20.
//  Copyright © 2020 Kamalesh Kumar Yadav. All rights reserved.
//

//

import XCTest
@testable import ContactApp

class ListDataSourceTest: XCTestCase {
	
	var dataSource : ListDataSource!
	
	override func setUp() {
		// Put setup code here. This method is called before the invocation of each test method in the class.
		dataSource = ListDataSource()
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		
		dataSource = nil
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
	
	func testEmptyValueInDataSource() {
		
		// giving empty data value
		dataSource.data.value = []
		
		let tableView = UITableView()
		tableView.dataSource = dataSource
		
		// expected one section
		XCTAssertEqual(dataSource.numberOfSections(in: tableView), 1, "Expected one section in table view")
		
		// expected zero cells
		XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 0, "Expected no cell in table view")
	}
	
	func testValueInDataSource() {
		
		// giving data value
		let firstRow = Contact(first_name: "kamalesh", last_name: "kumar", mobile_number: 8727013651, email_id: "abc@gmail.com", profile_image: "https://i.picsum.photos/id/237/200/300.jpg")
            //Contact(title: "kamlesh", description: "hi kamelsh supper is going ", imageHref: "https:image url")
		let secondrow = Contact(first_name: "yadav", last_name: "kumar", mobile_number: 8727013651, email_id: "abc@gmail.com", profile_image: "https://i.picsum.photos/id/237/200/300.jpg")
		dataSource.data.value = [firstRow, secondrow]
		
		let tableView = UITableView()
		tableView.dataSource = dataSource
		
		// expected one section
		XCTAssertEqual(dataSource.numberOfSections(in: tableView), 1, "Expected one section in table view")
		
		// expected two cells
		XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 2, "Expected two cell in table view")
	}
	
	func testValueCell() {
		
		// giving data value
		let firstRow = Contact(first_name: "kamalesh", last_name: "kumar", mobile_number: 8727013651, email_id: "abc@gmail.com", profile_image: "https://i.picsum.photos/id/237/200/300.jpg")
		dataSource.data.value = [firstRow]
		let tableView = UITableView()
		tableView.dataSource = dataSource
		tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: "ContactTableViewCell")
		
		let indexPath = IndexPath(row: 0, section: 0)
		
		// expected contactcell class
		guard let cell = dataSource.tableView(tableView, cellForRowAt: indexPath) as? ContactTableViewCell else {
			XCTAssert(false, "Expected contact class")
			return
		}
        XCTAssertEqual(cell.contactData?.first_name, "kamalesh", "Expected kamalesh")
        //print(data.contactData?.first_name)
	}
	
}
