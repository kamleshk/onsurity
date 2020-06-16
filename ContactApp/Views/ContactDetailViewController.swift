//
//  ContactDetailViewController.swift
//  ContactApp
//
//  Created by Kamalesh Kumar Yadav on 16/06/20.
//  Copyright © 2020 Kamalesh Kumar Yadav. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView! // showing profile image
    @IBOutlet weak var contectLbl: UILabel!    // heighliting and pouplating contect label
    var detailViewModel:ContactDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.setUpUi()
    }
    
    /// UI setup for showing contect detail
    func setUpUi() {
        guard let cont =  detailViewModel?.contect else {
        return }
        if let imgUrl = cont.profile_image{
            self.profileImage.loadImageUsingCache(withUrl: imgUrl)
        }
        self.contectLbl.attributedText = self.getTextLabel(contact: cont)
        self.title = cont.first_name
    }
    
    /// formating and modifying text of contect
    func getTextLabel(contact:Contact) -> NSAttributedString {
           let attributedText = NSMutableAttributedString()
           
           attributedText.append( NSAttributedString(string:"Name: ",attributes:
           [NSAttributedString.Key.foregroundColor: UIColor.black]))
           
           attributedText.append( NSAttributedString(string:contact.first_name,attributes:
           [NSAttributedString.Key.foregroundColor: UIColor.gray]))
           
           attributedText.append( NSAttributedString(string:"\n",attributes:[:]))
           
           
          attributedText.append( NSAttributedString(string:"Last Name: ",attributes:
           [NSAttributedString.Key.foregroundColor: UIColor.black]))
           
           attributedText.append( NSAttributedString(string:contact.last_name,attributes:
           [NSAttributedString.Key.foregroundColor: UIColor.gray]))
           
           attributedText.append( NSAttributedString(string:"\n",attributes:[:]))
           
           attributedText.append( NSAttributedString(string:"Mobile Number: ",attributes:
           [NSAttributedString.Key.foregroundColor: UIColor.black]))
           
           attributedText.append( NSAttributedString(string:"\(contact.mobile_number)",attributes:
           [NSAttributedString.Key.foregroundColor: UIColor.gray]))
           
           attributedText.append( NSAttributedString(string:"\n",attributes:[:]))
           
           attributedText.append( NSAttributedString(string:"Email: ",attributes:
           [NSAttributedString.Key.foregroundColor: UIColor.black]))
           
           attributedText.append( NSAttributedString(string:contact.email_id,attributes:
           [NSAttributedString.Key.foregroundColor: UIColor.gray]))
           
           return attributedText
       }

}
