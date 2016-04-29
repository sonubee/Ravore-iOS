import UIKit
import Foundation
import Firebase
import AirshipKit
import Toucan
/*
let braceletGo = braceletSelected
var messageUrl = useFirebase + "Messages/"
messageUrl += braceletGo

//getMessages =
*/
let firebaseMessage = Firebase(url:useFirebase).childByAppendingPath("Messages").childByAppendingPath(braceletSelected)

extension ViewControllerMessaging {
    
    func downloadObjects() {
        
        let braceletGo = braceletSelected
        var messageUrl = useFirebase + "Messages/"
        messageUrl += braceletGo
        
        //getMessages =
        
        firebaseMessage.observeEventType(.ChildAdded, withBlock: { snapshot in
            
            let message = snapshot.value.objectForKey("message") as! String
            let sender = snapshot.value.objectForKey("sender") as! String
            let date = snapshot.value.objectForKey("date") as! String
            let braceletId = snapshot.value.objectForKey("braceletId") as! String
            let timestamp = snapshot.value.objectForKey("timestamp") as! String
            
            let downloadMessage = ObjectMessage(message: message, sender: sender, date: date, braceletId: braceletId, timestamp: timestamp)
            arrayOfMessages.append(downloadMessage)
            
            print("Message Text is: \(downloadMessage.message)")
            
            self.tableView.reloadData()
            
            let lastIndex = NSIndexPath(forRow: arrayOfMessages.count - 1, inSection: 0)
            self.tableView.scrollToRowAtIndexPath(lastIndex, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
        })
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func finalPostOfTokenToServer() {
        
        PushToken.pushUAirship()
        
        UAirship.push().updateRegistration()
        
        let updateInfo = ["deviceId": UDID, "lastLogin": shortDate, "os" : "iOS" , "token" : deviceToken]
        
        Firebase(url:useFirebase+"UserInfo/\(UDID)").setValue(updateInfo)
        
        if foundToken == false {
            foundToken = true
            print("Token not found on Server -- Posting Token Onto Firebase")
            
            let postToken = Firebase(url: "\(useFirebase)Users/PushToken")
            let postTokenObject = ["os": "ios", "token": deviceToken, "userId": UDID]
            
            Firebase(url:useFirebase+"Users/\(UDID)").childByAppendingPath("token").setValue(deviceToken)
      
            postToken.childByAutoId().setValue(postTokenObject)
        }
        
  
    }
    
    func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    
    override func didMoveToParentViewController(parent: UIViewController?) {
        if parent == nil {
            print("Back Pressed")
            firebaseMessage.removeAllObservers()
        }
    }

}