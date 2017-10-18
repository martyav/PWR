//
//  SenatorViewControllerTableProtocolMethods.swift
//  PWR
//
//  Created by Marty Hernandez Avedon on 10/15/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import UIKit

extension SenatorViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            guard let sitsOnCommitee = self.commitees else { return 1 }
            
            if sitsOnCommitee.count <= 3 {
                return sitsOnCommitee.count
            } else {
                return 4
            }
        case 1:
            guard let cosponsoredABill = self.cosponsorships else { return 1 }
            
            if cosponsoredABill.count <= 3 {
                return cosponsoredABill.count
            } else {
                return 4
            }
        case 2:
            return self.votingRecord?.count ?? 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "votingOrCommitee", for: indexPath) as! CommitteeOrBillTableViewCell
        
        var cellText: String = ""
        
        switch indexPath.section {
        case 0:
            guard let sitsOnCommitee = commitees else {
                cellText = "No commitees"
                break
            }
            
            if indexPath.row < 3 {
                cellText = sitsOnCommitee[indexPath.row]
            } else if indexPath.row == 3 {
                cellText = "See more..."
                cell.segueIdentifier = Constants.segueToCommitteeVC
                if !cell.isUserInteractionEnabled { cell.isUserInteractionEnabled = true }
            }
        case 1:
            guard  let cosponsoredABill = cosponsorships else {
                cellText = "No co-sponsored bills"
                break
            }
            
            if indexPath.row < 3 {
                cellText = cosponsoredABill[indexPath.row].name
                cell.segueIdentifier = Constants.segueToBillDetailVC
            } else if indexPath.row == 3 {
                cellText = "See more..."
                cell.segueIdentifier = Constants.segueToCoSponsorshipVC
            }
            
            if !cell.isUserInteractionEnabled { cell.isUserInteractionEnabled = true }
        case 2:
            guard let votedOnABill = votingRecord else {
                cellText = "No bills voted on yet"
                break
            }
            
            cellText = votedOnABill[indexPath.row].bill.name
            if !cell.isUserInteractionEnabled { cell.isUserInteractionEnabled = true }
            
            if votedOnABill[indexPath.row].votedInFavor {
                cell.detailTextLabel?.text = "YES"
            } else {
                cell.detailTextLabel?.text = "NO"
            }
            
            cell.segueIdentifier = Constants.segueToBillDetailVC
        default:
            cellText = ""
        }
        
        cell.textLabel?.text = cellText
        
        if cell.textLabel?.text == "See more..." {
            cell.textLabel?.textColor = UIColor.PWRred
            cell.textLabel?.font = UIFont(name: "Avenir-LightOblique", size: 20)
        } else {
            cell.textLabel?.textColor = UIColor.black
            cell.textLabel?.font = UIFont(name: "Avenir-Roman", size: 20)
        }
        
        print(cell.segueIdentifier)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "votingOrCommitee", for: indexPath) as! CommitteeOrBillTableViewCell
        
        print(cell.segueIdentifier)
        
        if let segueAvailable = cell.segueIdentifier {
        var sender: Any = self
        
        if segueAvailable == Constants.segueToBillDetailVC {
            if indexPath.section == 1 {
                let bill = (cosponsorships?[indexPath.row])!
                sender = bill
            } else if indexPath.section == 2 {
                guard let record = self.votingRecord?[indexPath.row] else { return }
                sender = record.bill as Bill
            }
        }
        
        print(segueAvailable)
            performSegue(withIdentifier: segueAvailable, sender: sender)
            
        } else {
            return
        }
        
//        switch indexPath.section {
//        case 0:
//            performSegue(withIdentifier: Constants.segueToCommitteeVC, sender: self)
//        case 1:
//            if cell.textLabel?.text == "See more..." {
//                performSegue(withIdentifier: Constants.segueToCoSponsorshipVC, sender: self)
//            } else {
//                performSegue(withIdentifier: Constants.segueToBillDetailVC, sender: cosponsorships?[indexPath.row])
//            }
//        case 2:
//            guard let record = self.votingRecord?[indexPath.row] else { return }
//
//            performSegue(withIdentifier: Constants.segueToBillDetailVC, sender: record.bill)
//        default:
//            return
//        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Committees".uppercased()
        case 1:
            return "Co-sponsored Bills".uppercased()
        case 2:
            return "Voting Record".uppercased()
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.font = UIFont(name: "Avenir-Light", size: 20)
        header.textLabel?.adjustsFontSizeToFitWidth = true
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        let footer = view as! UITableViewHeaderFooterView
        
        footer.tintColor = UIColor.PWRred
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 3.0
    }
}
