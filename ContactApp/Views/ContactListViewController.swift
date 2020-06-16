//
//  ViewController.swift
//  ContactApp
//
//  Created by Kamalesh Kumar Yadav on 15/06/20.
//  Copyright © 2020 Kamalesh Kumar Yadav. All rights reserved.
//

import UIKit

class ContactListViewController: UIViewController {
	@IBOutlet weak var contactListView: UITableView!
	
	/// variable for tableview datasource which will responsible for creating list and displaying data in list each cell
	private var dataSource = ListDataSource()
	
	/// creating view model which is handaling all business logic
	private lazy var viewModel: ListViewModel = {
		let viewModel = ListViewModel(service: ContactListService(), dataSource: dataSource)
		return viewModel
	}()
	
	
	/// Viewcontroller lifecycle Methods
	override func viewDidLoad() {
		super.viewDidLoad()
		self.setupUi()
		self.addingObserver()
		self.observerError()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		//self.viewModel.fetchList()
	}
	
	/// Setting initial setup view which is going to be called when view going to load into memory
	func setupUi()  {
		self.contactListView.dataSource = self.dataSource
        self.contactListView.delegate = self.dataSource
	
	}
	
	
	
	/// Adding a observer  Which is going to notified when new data is available and this closers going to populate or refresh our tableview or list
	func addingObserver(){
		self.dataSource.data.addAndNotify(observer: self) { [weak self ] _ in
			self?.contactListView.reloadData()
		}
		self.dataSource.selectedData.addAndNotify(observer: self) { [weak self ] contact in
            print(contact)
            self?.pushtoDetail(contact: contact.first!)
           
        }
        
		
	}
	
	/// Handaling all error which we triggered from our view model  (business logic)
	func observerError()  {
		// add error handling example
		self.viewModel.onErrorHandling = { [weak self] error in
			// display error ?
			let controller = UIAlertController(title: "An error occured", message: "Oops, something went wrong!", preferredStyle: .alert)
			controller.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
			self?.present(controller, animated: true, completion: nil)
		}
	}
    
   
	
	/// handaling user sessions
    @IBAction func logoutBarBtnA(_ sender: Any) {
        
        let barBtn = sender as! UIBarButtonItem
        if barBtn.title == "Logout"{
            self.viewModel.logout()
            barBtn.title = "Login"
            self.title = "Guest"
        }else{
        let loadingAlert = UIAlertController.loadingAlert()
            loadingAlert.presentInViewController(self)
        self.viewModel.login {[weak self] (isAuth, userInfo) in
            loadingAlert.dismiss(animated: true) {}
            if isAuth{
                self?.title = userInfo!.name
                barBtn.title = "Logout"
                self?.viewModel.fetchList()
            }
           
         }
      }
    }
    
    func pushtoDetail(contact:Contact)  {
        let detaiCont = self.storyboard?.instantiateViewController(identifier: "ContactDetailViewController") as! ContactDetailViewController
        detaiCont.detailViewModel = ContactDetailViewModel(contact: contact)
        self.navigationController?.pushViewController(detaiCont, animated: true)
        
    }
}



