//
//  ContactDetailViewController.swift
//  ContactApp
//
//  Created by Kamalesh Kumar Yadav on 16/06/20.
//  Copyright © 2020 Kamalesh Kumar Yadav. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var contectLbl: UILabel!
    var detailViewModel:ContactDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setUpUi()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setUpUi() {
        guard let cont =  detailViewModel?.contect else {
        return }
        if let imgUrl = cont.profile_image{
            self.profileImage.loadImageUsingCache(withUrl: imgUrl)
        }
        self.contectLbl.attributedText = self.getTextLabel(contact: cont)
        self.title = cont.first_name
    }
    
    
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
