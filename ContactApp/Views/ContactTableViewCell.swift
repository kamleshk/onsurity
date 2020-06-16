//
//  ContactTableViewCell.swift
//  ContactApp
//
//  Created by kamlesh kumar on 15/06/20.
//  Copyright © 2020 Kamalesh Kumar Yadav. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

	@IBOutlet weak var profileImage: UIImageView!
	@IBOutlet weak var detailLbl: UILabel!
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    // setting value to cell
    var contactData:Contact? {
        didSet {
            guard let rowmodel = contactData else {  return }
            if let imageurl = rowmodel.profile_image {
                if self.profileImage != nil{
                self.profileImage.loadImageUsingCache(withUrl : imageurl)
                }}
            if self.detailLbl != nil {
            self.detailLbl.attributedText = self.getTextLabel(contact: rowmodel)
            }
        }
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
