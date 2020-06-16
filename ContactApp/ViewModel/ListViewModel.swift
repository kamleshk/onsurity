//
//  ListViewModel.swift
//  ContactApp
//
//  Created by kamlesh kumar on 16/06/20.
//  Copyright © 2020 Kamalesh Kumar Yadav. All rights reserved.
//

import Foundation
import Auth0
struct ListViewModel {
	
	private var dataSource: GenericDataSource<Contact>?
	public var service: ContactServiceProtocol?
	public var onErrorHandling: ((ErrorResult?) -> Void)? // call back for passing event if any failure happen with business logic
    
	init(service: ContactServiceProtocol , dataSource: GenericDataSource<Contact>) {
		self.dataSource = dataSource
		self.service = service
	}
	
	
	///  Method for calling api
	internal func fetchList() {
		guard let service = service else {
			onErrorHandling?(ErrorResult.custom(string: "Missing service"))
			return
		}
		// calling api and reloading on main thread
		service.fetchContactList { result in
			DispatchQueue.main.async {
				switch result {
				case .success(let contactModel) :
					print(contactModel)
				//	self.messagePassing?(factsModel.title)
					self.dataSource?.data.value = contactModel.data ?? []
				case .failure(let error) :
					self.onErrorHandling?(error)
				}
			}
		}
	}
    
    
    func login(complition:@escaping (_ autharised:Bool,_ userDetail:UserInfo)->Void) {
        checkAccessToken(complition: complition)
        
      
    }
    
    func showLog(complition:@escaping (_ autharised:Bool,_ userDetail:UserInfo)->Void)  {
         guard let clientInfo = plistValues(bundle: Bundle.main) else { return }
                    Auth0
                        .webAuth()
                        .audience("https://" + clientInfo.domain + "/api/v2/")
                        .scope("openid profile")
                        .start {
                            switch $0 {
                            case .failure(let error):
                                // Handle the error
                                print("Error: \(error)")
                            case .success(let credentials):
                                guard let accessToken = credentials.accessToken, let idToken = credentials.idToken else { return }
                                SessionManager.shared.storeTokens(accessToken, idToken: idToken)
                                SessionManager.shared.retrieveProfile { error in
                                    guard error == nil else {
                                        return self.login(complition: complition)
                                    }
                                    DispatchQueue.main.async {
                                        complition(true,SessionManager.shared.profile!)
                                    }
                                }
                            }
                    }
    }
    
    
    fileprivate func checkAccessToken(complition: @escaping (_ autharised:Bool,_ userDetail:UserInfo)->Void) {
      SessionManager.shared.retrieveProfile { error in
          DispatchQueue.main.async {
              //loadingAlert.dismiss(animated: true) {
                  guard error == nil else {
                    return self.showLog(complition: complition)
                  }
            complition(true,SessionManager.shared.profile!)
              }
          //}
      }
  }
    
     func logout() {
        SessionManager.shared.logout()
        self.dataSource?.data.value = []
    }
    
}
