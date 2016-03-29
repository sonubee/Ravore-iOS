//
//  AddReceiver.swift
//  Ravore2
//
//  Created by Admin on 3/28/16.
//  Copyright © 2016 G LLC. All rights reserved.
//

import UIKit
import Firebase

class AddReceiver {
    
    func braceletExistence(braceletId : String) -> Bool {
        var found = false
        
        for bracelet : ObjectBracelet in allBracelets {
            if bracelet.braceletId == braceletId {
                found = true
            }
            
        }
        return found
    }
    
    
    func getBracelet(braceletId : String) -> ObjectBracelet {
        //var found = false
        var tempBracelet = ObjectBracelet()
        
        for bracelet : ObjectBracelet in allBracelets {
            if bracelet.braceletId == braceletId {
                braceletChosen = bracelet
                tempBracelet = bracelet
            }
            
        }
        return tempBracelet
    }
    
    func addBracelet (braceletId : String) {
        var firebaseKey : String!
        firebaseKey = braceletKeys[braceletSelected]
        
        let postReceiver = Firebase(url:useFirebase+"Bracelets")
        
        var shortDate : String {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM/dd/yy"
            return dateFormatter.stringFromDate(NSDate())
        }
        
        let postNewReceiver = ["giverId": braceletChosen.giverId, "dateRegistered": braceletChosen.dateRegistered, "receiverId" : UDID , "dateCreated" : braceletChosen.dateCreated, "braceletId" : braceletChosen.braceletId, "dateReceived" : shortDate]
        
        postReceiver.childByAppendingPath(firebaseKey).setValue(postNewReceiver)
        
        registeredBracelets.append(braceletChosen)
        
        SendPush.methodToTest("Bracelet \(braceletSelected) Has Been Added!", messageReceiverId: braceletChosen.giverId, title: braceletSelected, type: "addition", braceletId: braceletSelected)
        
    }
}
