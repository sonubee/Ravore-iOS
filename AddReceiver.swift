
import UIKit
import Firebase

class AddReceiver {
    
    func overallProcess(braceletId : String) -> String{
        
        var tempString = ""
        
        if (BraceletInfo().braceletExistence(braceletSelected)) {
            braceletChosen = BraceletInfo().getBracelet(braceletSelected)
            if (braceletChosen.receiverId == UDID){
                tempString = "goToAllMessages"
            }
                
            else if (braceletChosen.giverId == UDID){
                Toast.makeToast("You Are Registered as the Giver").show()
            }
                
            else if (braceletChosen.giverId != "NA" && braceletChosen.receiverId == "NA"){
                AddReceiver().addBracelet(braceletSelected)
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
        
        let postNewReceiver2 = ["giverId": braceletChosen.giverId, "dateRegistered": braceletChosen.dateRegistered, "receiverId" : UDID , "dateCreated" : braceletChosen.dateCreated, "braceletId" : braceletChosen.braceletId, "dateReceived" : shortDate, "transferNumber" : 1]
        
        
        postReceiver.childByAppendingPath(firebaseKey).setValue(postNewReceiver)
        
        let postNewWay = Firebase(url: useFirebase).childByAppendingPath("IDs").childByAppendingPath(braceletSelected).childByAppendingPath("1").childByAppendingPath("Info")
        postNewWay.setValue(postNewReceiver2)
        
        registeredBracelets.append(braceletChosen)
        
        SendPush.methodToTest("Bracelet \(braceletSelected) Has Been Added!", messageReceiverId: braceletChosen.giverId, title: braceletSelected, type: "addition", braceletId: braceletSelected)
        
        let addReceiverObject = ObjectBracelet(receiverId: UDID, giverId: braceletChosen.giverId, dateCreated: braceletChosen.dateCreated, dateReceived: shortDate, dateRegistered: braceletChosen.dateRegistered, braceletId: braceletChosen.braceletId)
        
        let addReceiverObject2 = ObjectBracelet2(receiverId: UDID, giverId: braceletChosen.giverId, dateCreated: braceletChosen.dateCreated, dateReceived: shortDate, dateRegistered: braceletChosen.dateRegistered, braceletId: braceletChosen.braceletId, transferNumber : 1)
        
        for (var i=0 ; i < allBracelets.count; i++) {
            if allBracelets[i].braceletId == braceletSelected {
                allBracelets[i] = addReceiverObject
            }
        }
        
    }
}
