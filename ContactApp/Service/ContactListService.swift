//
//  ContactListService.swift
//  ContactApp
//
//  Created by Kamalesh Kumar Yadav on 15/06/20.
//  Copyright © 2020 Kamalesh Kumar Yadav. All rights reserved.
//

import Foundation


protocol ContactServiceProtocol : class {
    func fetchContactList(_ completion: @escaping ((Result<Contacts, ErrorResult>) -> Void))
}

final class ContactListService : RequestHandler {
    
    static let shared = ContactListService()
    // letter i will make as base url and componenet of url for now i am keeping single url
    let endpoint = "https://7yd7u01nw9.execute-api.ap-south-1.amazonaws.com/prod/contact-list"
    var task : URLSessionTask?
    
    /// Cancelling api request which is running
    func cancelFetchCurrencies() {
        if let task = task {
            task.cancel()
        }
        task = nil
    }
}


extension ContactListService : ContactServiceProtocol {
	func fetchContactList(_ completion: @escaping ((Result<Contacts, ErrorResult>) -> Void)) {
		self.cancelFetchCurrencies()
		task = RequestService().loadData(urlString: endpoint, completion:
				self.networkResult(completion: completion)
		)
	}
}
