import UIKit
import Foundation
import Firebase
import AirshipKit
import Toucan

extension ViewControllerMessaging {
    
    
    
    func downloadObjects() {
        

        
        let braceletGo = braceletSelected
        var messageUrl = useFirebase + "Messages/"
        messageUrl += braceletGo
        
        getMessages = Firebase(url:messageUrl)
        
        getMessages.observeEventType(.ChildAdded, withBlock: { snapshot in
            
            let message = snapshot.value.objectForKey("message") as! String
            let sender = snapshot.value.objectForKey("sender") as! String
            let date = snapshot.value.objectForKey("date") as! String
            let braceletId = snapshot.value.objectForKey("braceletId") as! String
            let timestamp = snapshot.value.objectForKey("timestamp") as! String
            
            let downloadMessage = ObjectMessage(message: message, sender: sender, date: date, braceletId: braceletId, timestamp: timestamp)
            arrayOfMessages.append(downloadMessage)
            
            self.tableView.reloadData()
            
            let lastIndex = NSIndexPath(forRow: arrayOfMessages.count - 1, inSection: 0)
            self.tableView.scrollToRowAtIndexPath(lastIndex, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
        })
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func finalPostOfTokenToServer() {
        if UAirship.push().deviceToken != nil {
            print("Device Token from Messaging: ",UAirship.push().deviceToken!)
            
            if UAirship.push().channelID == nil {
                channelID = "not set yet"
                print("Channel ID Not Set Yet")
            }
                
            else {
                channelID = UAirship.push().channelID!
                print("--Channel ID: \(channelID)")
            }
            
            deviceToken = UAirship.push().deviceToken!
            print("--Device Token: \(UAirship.push().deviceToken!)")
            
            print("before the false statement")
            if foundToken == false {
                foundToken = true
                print("Token not found on Server -- Posting Token Onto Firebase")
                
                let postToken = Firebase(url: "\(useFirebase)Users/PushToken")
                let postTokenObject = ["os": "ios", "token": deviceToken, "userId": UDID]
                
                //if devStatus == "production"{
                    //Firebase(url:useFirebase+"Users/\(UDID)").childByAppendingPath("token").setValue(postTokenObject)
                    Firebase(url:useFirebase+"Users/\(UDID)").childByAppendingPath("token").setValue(deviceToken)
                //}
                
                
                postToken.childByAutoId().setValue(postTokenObject)
            }
            print("end of posting token in messaging")
        }
    }
    
    func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func setup(){
        
        
        self.tableView.rowHeight = 25
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Bordered, target: self, action: "back:")
        self.navigationItem.leftBarButtonItem = newBackButton;
        // Do any additional setup after loading the view.
        
        let tapGiverGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("giverImageTapped:"))
        giverImage.userInteractionEnabled = true
        giverImage.addGestureRecognizer(tapGiverGestureRecognizer)
        
        let tapReceiverGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("receiverImageTapped:"))
        receiverImage.userInteractionEnabled = true
        receiverImage.addGestureRecognizer(tapReceiverGestureRecognizer)
        
        giverImage.image = UIImage(named: "anon")
        receiverImage.image = UIImage(named: "anon")
        
        var tempImage : UIImage
        tempImage = giverImage.image!
        
        let resizedAndMaskedImage = Toucan(image: tempImage).resize(CGSize(width: 70, height: 70), fitMode: Toucan.Resize.FitMode.Crop).image
        
        giverImage.image = resizedAndMaskedImage
        receiverImage.image = resizedAndMaskedImage
        
        print("end of setup")
        
    }
    
    

}