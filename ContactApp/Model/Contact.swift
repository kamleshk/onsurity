//
//  Contact.swift
//  ContactApp
//
//  Created by Kamalesh Kumar Yadav on 15/06/20.
//  Copyright © 2020 Kamalesh Kumar Yadav. All rights reserved.
//

import Foundation



struct Contacts:Decodable {
	let success:Int
	let msg:String
	let data:[Contact]?
}

struct Contact : Decodable {
    let first_name:String
    let last_name:String
    let mobile_number:Int
    let email_id:String
    let profile_image:String?
}
