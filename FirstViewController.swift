
var braceletSelected=""
var braceletChosen = ObjectBracelet()
import Firebase
var allBracelets = [ObjectBracelet]()
var registeredBracelets = [ObjectBracelet]()
var allPics = [ObjectProfilePic]()
var allOrders = [ObjectOrders]()
var allUsers = [ObjectAllUsers]()
var allTokens = [ObjectToken]()
var allIDs = [String]()
var foundToken = false
import PKHUD
var braceletKeys = [String:String]()
var gcmTokens = [String:String]()
let UDID = UIDevice.currentDevice().identifierForVendor!.UUIDString
//import Localytics
var cameFromHome = true


var shortDate : String {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "MM/dd/yy"
    return dateFormatter.stringFromDate(NSDate())
}

let productionTokenBT = "production_x75kb8hy_69ppkf6h8fqh9cxb"
let sandboxTokenBT = "sandbox_7v37j3pm_9j46c9m8t3mjfwwq"

let productionHerokuURL = "https://sheltered-wave-14675.herokuapp.com/checkout"
let sandboxHerokuURL = "https://hidden-river-58763.herokuapp.com/checkout"

let sandboxFirebase = "https://testravore.firebaseio.com/"
let productionFirebase = "https://liveravore.firebaseio.com/"

var useHeroku = ""
var useBT = ""
var useFirebase = ""

let devStatus = "sandbox"

import UIKit

class FirstViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var braceletIdFromLogin: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //SendPush.methodToTest("message", receiver: "test")
        
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0;
        
        print("before file--------")
        if let resourceUrl = NSBundle.mainBundle().URLForResource("apns-dev-cert", withExtension: "p12") {
            if NSFileManager.defaultManager().fileExistsAtPath(resourceUrl.path!) {
                print("file found!!!!!")
            }
        }
        
        TestClassFile.methodToTest()
    
        Localytics.tagEvent("iOS Localytics")
        Localytics.setCustomerId(UDID)
        
        //self.navigationController?.navigationBarHidden = true
        // Do any additional setup after loading the view, typically from a nib.
        
        if (devStatus == "sandbox"){
            useHeroku = productionHerokuURL
            useBT = sandboxTokenBT
            useFirebase = sandboxFirebase
        }
        
        if (devStatus == "production"){
            useHeroku = productionHerokuURL
            useBT = productionTokenBT
            useFirebase = productionFirebase
        }
        
        HUD.show(.Progress)
        downloadObjects()
        
        self.braceletIdFromLogin.delegate=self
        braceletIdFromLogin.keyboardType = UIKeyboardType.NumberPad
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        cameFromHome=true
         self.navigationController?.navigationBarHidden = true
    }
    
    @IBAction func giverLogin(sender: UIButton) {
        self.braceletIdFromLogin.resignFirstResponder()
        braceletSelected=String(braceletIdFromLogin.text!)
        braceletIdFromLogin.text = ""
        
        for bracelet : ObjectBracelet in allBracelets {
            if bracelet.braceletId == braceletSelected {
                braceletChosen = bracelet;}}
        
        var found = false
        for braceletIdFromLogin: ObjectBracelet in allBracelets {
            if (braceletIdFromLogin.braceletId==braceletSelected){
                
                found=true
                
                if (braceletIdFromLogin.giverId == UDID){
                    self.performSegueWithIdentifier("goToAllMessages", sender: self)
                    
                }
                    
                else if (braceletIdFromLogin.receiverId == UDID){
                    Toast.makeToast("You Are Registered as the Receiver").show()
                }
                    
                    
                else if (braceletIdFromLogin.giverId == "NA" && braceletIdFromLogin.receiverId == "NA"){
                    var firebaseKey : String!
                    firebaseKey = braceletKeys[braceletSelected]
                    
                    let postGiver = Firebase(url:useFirebase+"Bracelets")
                    
                    let postNewGiver = ["giverId": UDID, "dateRegistered": shortDate, "receiverId" : "NA" , "dateCreated" : braceletIdFromLogin.dateCreated, "braceletId" : braceletIdFromLogin.braceletId, "dateReceived" : "NA"]
                    postGiver.childByAppendingPath(firebaseKey).setValue(postNewGiver)
                
                    registeredBracelets.append(braceletIdFromLogin)
                    
                    self.performSegueWithIdentifier("goToAllMessages", sender: self)
                }
                    
                else if (braceletIdFromLogin.giverId != "NA" && braceletIdFromLogin.receiverId == "NA") {
                    Toast.makeToast("There's already a Giver Registered. Are you the Receiver?").show()
                }
                    
                else if (braceletIdFromLogin.giverId != "NA" && braceletIdFromLogin.receiverId != "NA"){
                    Toast.makeToast("Bracelet Already Taken!").show()
                }
            }
            
        }
        
        if (!found){
            Toast.makeToast("Bracelet Doesn't Exist!").show()
        }
    }
    
    @IBAction func receiverLogin(sender: UIButton) {
        self.braceletIdFromLogin.resignFirstResponder()
        braceletSelected=String(braceletIdFromLogin.text!)
        braceletIdFromLogin.text = ""
        
        for bracelet : ObjectBracelet in allBracelets {
            if bracelet.braceletId == braceletSelected {
                braceletChosen = bracelet;}}
        
        var found = false
        for braceletIdFromLogin: ObjectBracelet in allBracelets {
            if (braceletIdFromLogin.braceletId==braceletSelected){
                found=true
               
                
                if (braceletIdFromLogin.receiverId == UDID){
                    self.performSegueWithIdentifier("goToAllMessages", sender: self)
                }
               
                else if (braceletIdFromLogin.giverId == UDID){
                    
                    Toast.makeToast("You Are Registered as the Giver").show()
                }
                
                else if (braceletIdFromLogin.giverId != "NA" && braceletIdFromLogin.receiverId == "NA"){
                    var firebaseKey : String!
                    firebaseKey = braceletKeys[braceletSelected]
                    
                    let postReceiver = Firebase(url:useFirebase+"Bracelets")
                    
                    var shortDate : String {
                        let dateFormatter = NSDateFormatter()
                        dateFormatter.dateFormat = "MM/dd/yy"
                        return dateFormatter.stringFromDate(NSDate())
                    }
                    
                 
                    
                    let postNewReceiver = ["giverId": braceletIdFromLogin.giverId, "dateRegistered": braceletIdFromLogin.dateRegistered, "receiverId" : UDID , "dateCreated" : braceletIdFromLogin.dateCreated, "braceletId" : braceletIdFromLogin.braceletId, "dateReceived" : shortDate]
                    postReceiver.childByAppendingPath(firebaseKey).setValue(postNewReceiver)

                     registeredBracelets.append(braceletIdFromLogin)
                    
                    SendPush.methodToTest("Bracelet \(braceletSelected) Has Been Added!", messageReceiverId: braceletIdFromLogin.giverId, title: braceletSelected, type: "addition", braceletId: braceletSelected)
                
                    self.performSegueWithIdentifier("goToAllMessages", sender: self)
                }
                    
                else if (braceletIdFromLogin.giverId == "NA" && braceletIdFromLogin.receiverId == "NA") {
                    Toast.makeToast("There's No Giver Registered. Is that you?").show()
                    
                }
                    
                else if (braceletIdFromLogin.giverId != "NA" && braceletIdFromLogin.receiverId != "NA"){
                    Toast.makeToast("Bracelet Already Taken!").show()
                }
            }
        }
        if (!found){
           
            Toast.makeToast("Bracelet Doesn't Exist!").show()
        }
        
    }
    
    func downloadObjects(){
        
        var count=0
        
        let getBracelets = Firebase(url:useFirebase+"Bracelets")
        
        getBracelets.observeEventType(.ChildAdded, withBlock: { snapshot in
        
            let receiver = snapshot.value.objectForKey("receiverId") as! String
            let giver = snapshot.value.objectForKey("giverId") as! String
            let created = snapshot.value.objectForKey("dateCreated") as! String
            let registered = snapshot.value.objectForKey("dateRegistered") as! String
            let received = snapshot.value.objectForKey("dateReceived") as! String
            let id = snapshot.value.objectForKey("braceletId") as! String
            
            let newBracelet = ObjectBracelet(receiverId: receiver, giverId: giver, dateCreated: created, dateReceived: received, dateRegistered: registered, braceletId: id)

            allBracelets.append(newBracelet)
            allIDs.append(id)
            
            braceletKeys[id] = snapshot.key
            
            if (newBracelet.giverId == UDID || newBracelet.receiverId == UDID){
                registeredBracelets.append(newBracelet)
                self.performSegueWithIdentifier("goToAllMessages", sender: self)
            }
            
            HUD.hide(afterDelay: 1.0)
            count++
        })
        
        getBracelets.observeEventType(.ChildChanged, withBlock: { snapshot in
            let title = snapshot.value.objectForKey("braceletId") as! String
           
            
            let receiver = snapshot.value.objectForKey("receiverId") as! String
            let giver = snapshot.value.objectForKey("giverId") as! String
            let created = snapshot.value.objectForKey("dateCreated") as! String
            let registered = snapshot.value.objectForKey("dateRegistered") as! String
            let received = snapshot.value.objectForKey("dateReceived") as! String
            let id = snapshot.value.objectForKey("braceletId") as! String
            
            let modifyBracelet = ObjectBracelet(receiverId: receiver, giverId: giver, dateCreated: created, dateReceived: received, dateRegistered: registered, braceletId: id)
    
            for (var i = 0; i < allBracelets.count ; i++) {
                if (allBracelets[i].braceletId == modifyBracelet.braceletId){
                    allBracelets[i] = modifyBracelet
                }
            }
        })
        
        let getPics = Firebase(url:useFirebase+"Users/ProfilePics")
        
        getPics.observeEventType(.ChildAdded, withBlock: { snapshot in
            
            let fullPhotoUrl = snapshot.value.objectForKey("fullPhotoUrl") as! String
            let fullPhotoVersion = snapshot.value.objectForKey("fullPhotoVersion") as! String
            let url = snapshot.value.objectForKey("url") as! String
            let urlVersion = snapshot.value.objectForKey("urlVersion") as! String
            let userId = snapshot.value.objectForKey("userId") as! String
            
            let addProfile = ObjectProfilePic(userId: userId, url: url, urlVersion: urlVersion, fullPhotoUrl: fullPhotoUrl, fullPhotoVersion: fullPhotoVersion)
            
            allPics.append(addProfile)
        })
        
        getPics.observeEventType(.ChildChanged, withBlock: { snapshot in
            
            let fullPhotoUrl = snapshot.value.objectForKey("fullPhotoUrl") as! String
            let fullPhotoVersion = snapshot.value.objectForKey("fullPhotoVersion") as! String
            let url = snapshot.value.objectForKey("url") as! String
            let urlVersion = snapshot.value.objectForKey("urlVersion") as! String
            let userId = snapshot.value.objectForKey("userId") as! String
            
            let modifyProfile = ObjectProfilePic(userId: userId, url: url, urlVersion: urlVersion, fullPhotoUrl: fullPhotoUrl, fullPhotoVersion: fullPhotoVersion)
            
            for (var i = 0; i < allPics.count ; i++) {
                if (allPics[i].userId == modifyProfile.userId){
                    allPics[i] = modifyProfile
                }
            }
        })
        
        let getAllUsers = Firebase(url:useFirebase+"Users/AllUsers")
        
        getAllUsers.observeEventType(.ChildAdded, withBlock: { snapshot in
            
            let dateCreated = snapshot.value.objectForKey("dateCreated") as! String
            let userId = snapshot.value.objectForKey("userId") as! String
            
            let addUser = ObjectAllUsers(userId: userId, dateCreated: dateCreated)
            
            allUsers.append(addUser)
            
            //let addProfile = ObjectProfilePic(userId: userId, url: url, urlVersion: urlVersion, fullPhotoUrl: fullPhotoUrl, fullPhotoVersion: fullPhotoVersion)
            
            //allPics.append(addProfile)
        })
        
        //let postOrder = Firebase(url:useFirebase+"Orders")
        //let postTestOrder = Firebase(url:useFirebase+"OrdersTest")
    
        let getAllOrders = Firebase(url:useFirebase+"Orders")
            
        //let getAllOrders = Firebase(url:useFirebase+"OrdersTest")
        
        getAllOrders.observeEventType(.ChildAdded, withBlock: { snapshot in
            
            let address = snapshot.value.objectForKey("address") as! String
            let beadCount = snapshot.value.objectForKey("beadCount") as! Int
            let date = snapshot.value.objectForKey("date") as! String
            let deviceId = snapshot.value.objectForKey("deviceId") as! String
            let email = snapshot.value.objectForKey("email") as! String
            let fullName = snapshot.value.objectForKey("fullName") as! String
            let kandiCount = snapshot.value.objectForKey("kandiCount") as! Int
            let orderNumber = snapshot.value.objectForKey("orderNumber") as! String
            let os = snapshot.value.objectForKey("os") as! String
            let shippingPrice = snapshot.value.objectForKey("shippingPrice") as! Double
            let status = snapshot.value.objectForKey("status") as! String
            let subtotalPrice = snapshot.value.objectForKey("subtotalPrice") as! Int
            let suiteApt = snapshot.value.objectForKey("suiteApt") as! String
            let totalPrice = snapshot.value.objectForKey("totalPrice") as! Double
            
            let downloadOrder = ObjectOrders(kandiCount: kandiCount, beadCount: beadCount, subtotalPrice: subtotalPrice, shippingPrice: shippingPrice, totalPrice: totalPrice, orderNumber: orderNumber, os: os, address: address, date: date, email: email, fullName: fullName, suiteApt: suiteApt, status: status, deviceId: deviceId)
            
            if downloadOrder.deviceId == UDID {
                 allOrders.append(downloadOrder)
            }
        })
        
        let getGCMTokens = Firebase(url:useFirebase+"Users/PushToken")
        
        getGCMTokens.observeEventType(.ChildAdded, withBlock: { snapshot in
        
            //gcmTokens[snapshot.key] = snapshot.value as! String
            let os = snapshot.value.objectForKey("os") as! String
            let token = snapshot.value.objectForKey("token") as! String
            let userId = snapshot.value.objectForKey("userId") as! String
            
            let downloadToken = ObjectToken(os: os, token: token, userId: userId)
 
            allTokens.append(downloadToken)
            
            print("--Searching Tokens on Firebase--")
            print("UserId: ", userId)
            print("Token on Firebase: ", token)
            print("This device Token: ", deviceToken)
            
            if (deviceToken != "not set yet") {
                if token == deviceToken {
                    foundToken = true
                    print("TOKEN FOUND ON SERVER")
                }
            }
        })
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }


}
