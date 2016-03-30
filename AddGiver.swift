//
//  AddGiver.swift
//  Ravore2
//
//  Created by Admin on 3/28/16.
//  Copyright © 2016 G LLC. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class AddGiver {
    
    func overallProcess(braceletId : String) -> String {
        
        var tempString = ""
        
        if (BraceletInfo().braceletExistence(braceletSelected)) {
            braceletChosen = BraceletInfo().getBracelet(braceletSelected)
            if (braceletChosen.giverId == UDID){
                tempString = "goToAllMessages"
            }
                
            else if (braceletChosen.receiverId == UDID){
                Toast.makeToast("You Are Registered as the Receiver").show()
            }
                
            else if (braceletChosen.giverId == "NA" && braceletChosen.receiverId == "NA"){
                AddGiver().addBracelet(braceletSelected)
                tempString = "goToAllMessages"
            }
                
            else if (braceletChosen.giverId != "NA" && braceletChosen.receiverId == "NA") {
                Toast.makeToast("There's already a Giver Registered. Are you the Receiver?").show()
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
    
    func addBracelet(braceletId : String) {
        var firebaseKey : String!
        firebaseKey = braceletKeys[braceletSelected]
        
        let postGiver = Firebase(url:useFirebase+"Bracelets")
        
        let postNewGiver = ["giverId": UDID, "dateRegistered": shortDate, "receiverId" : "NA" , "dateCreated" : braceletChosen.dateCreated, "braceletId" : braceletChosen.braceletId, "dateReceived" : "NA"]
        postGiver.childByAppendingPath(firebaseKey).setValue(postNewGiver)
        
        //if devStatus == "production"{
            let sendBody = "braceletId=\(braceletId)"
            SendServerRequest.sendRequest("\(useHeroku)BraceletAddedEmail", body: sendBody)
        //}
        
        registeredBracelets.append(braceletChosen)
    }
    
}