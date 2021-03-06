//
//  Senator.swift
//  PWR
//
//  Created by Amber Spadafora on 10/3/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import Foundation

struct Senator {
    var firstName: String
    var lastName: String
    var party: String
    var state: String
    var address: String
    var phone: String
    var website: URL?
    var memberID: String
}
extension Senator {
    init?(dict: [String: String]) {
        guard let fName = dict["first_name"] else { return nil }
        guard let lName = dict["last_name"] else { return nil }
        guard let state = dict["state"] else { return nil }
        guard let party = dict["party"] else { return nil }
        guard let phone = dict["phone"] else { return nil }
        guard let address = dict["address"] else { return nil }
        guard let web = dict["website"] else { return nil }
        guard let id = dict["bioguide_id"] else {return nil}
        
        let website = URL(string: web)
        self.init(firstName: fName, lastName: lName, party: party, state: state, address: address, phone: phone, website: website, memberID: id)
    }
    
}

//<member>
//<member_full>Barrasso (R-WY)</member_full>
//<last_name>Barrasso</last_name>
//<first_name>John</first_name>
//<party>R</party>
//<state>WY</state>
//<address>
//307 Dirksen Senate Office Building Washington DC 20510
//</address>
//<phone>(202) 224-6441</phone>
//<email>
//https://www.barrasso.senate.gov/public/index.cfm/contact-form
//</email>
//<website>http://www.barrasso.senate.gov</website>
//<class>Class I</class>
//<bioguide_id>B001261</bioguide_id>
//</member>

