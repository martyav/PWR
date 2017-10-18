//
//  CommitteeTableViewCell.swift
//  PWR
//
//  Created by Marty Hernandez Avedon on 10/18/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import UIKit

class CommitteeOrBillTableViewCell: UITableViewCell {
    var segueIdentifier: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.isUserInteractionEnabled = false
        self.textLabel?.text = ""
        self.detailTextLabel?.text = ""
        self.textLabel?.font = UIFont(name: "Avenir-Roman", size: 20)
        self.textLabel?.textColor = UIColor.black
        self.detailTextLabel?.font = UIFont(name: "Avenir-Oblique", size: 20)
    }
    
    override func prepareForReuse() {
        if self.isUserInteractionEnabled { self.isUserInteractionEnabled = false }
        
       // self.segueIdentifier = nil
        self.textLabel?.text = ""
        self.detailTextLabel?.text = ""
        self.textLabel?.font = UIFont(name: "Avenir-Roman", size: 20)
        self.textLabel?.textColor = UIColor.black
        self.detailTextLabel?.font = UIFont(name: "Avenir-Oblique", size: 20)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
