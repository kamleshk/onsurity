//
//  ListDataSource.swift
//  ContactApp
//
//  Created by kamlesh kumar on 16/06/20.
//  Copyright © 2020 Kamalesh Kumar Yadav. All rights reserved.
//

import UIKit

class GenericDataSource<T>: NSObject {
	var data: DynamicValue<[T]> = DynamicValue([])
}

class ListDataSource: GenericDataSource<Contact> {
}
extension ListDataSource: UITableViewDataSource {
	
	/// Tableview datasource methods
	/// - Parameter tableView: listtableview
	/// - Returns: number of section as integer value
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return data.value.count
	}
	
	/// Method responsible for creating each cell and populating data to each cell
	/// - Parameters:
	///   - tableView: own tableView
	///   - indexPath: indexpath for each cell
	/// - Returns: uitableview cell ie ListTableviewCell
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell", for: indexPath) as! ContactTableViewCell
    //cell.rowModel = self.data.value[indexPath.row]
		//print(self.data.value[indexPath.row])
        cell.contactData = self.data.value[indexPath.row]
		
		return cell
	}
}
