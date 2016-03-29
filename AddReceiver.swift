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
    
    func overallProcess(braceletId : String) -> String{
        
        var tempString = ""
        
        if (AddReceiver().braceletExistence(braceletSelected)) {
            braceletChosen = AddReceiver().getBracelet(braceletSelected)
            if (braceletChosen.receiverId == UDID){
                //self.performSegueWithIdentifier("goToAllMessages", sender: self)
                tempString = "goToAllMessages"
            }
                
            else if (braceletChosen.giverId == UDID){
                Toast.makeToast("You Are Registered as the Giver").show()
            }
                
            else if (braceletChosen.giverId != "NA" && braceletChosen.receiverId == "NA"){
                AddReceiver().addBracelet(braceletSelected)
                //self.performSegueWithIdentifier("goToMessageFromAdd", sender: self)
                tempString = "goToAllMessages"
            }
                
            else if (braceletChosen.giverId == "NA" && braceletChosen.receiverId == "NA") {
                Toast.makeToast("Not Found").show()
                
            }
                
            else if (braceletChosen.giverId != "NA" && braceletChosen.receiverId != "NA"){
                Toast.makeToast("Bracelet Already Taken!").show()
            }
        }
            
        else {
            Toast.makeToast("Bracelet Doesn't Exist!").show()
        }
        
        return tempString
    }
    
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
