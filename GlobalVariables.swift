

import Foundation

var braceletChosen = ObjectBracelet()
var allBracelets = [ObjectBracelet]()
var registeredBracelets = [ObjectBracelet]()
var allPics = [ObjectProfilePic]()
var allOrders = [ObjectOrders]()
var allUsers = [ObjectAllUsers]()
var allTokens = [ObjectToken]()
var allEvents = [ObjectEvents]()

var braceletSelected=""

var allIDs = [String]()
var foundToken = false
var braceletKeys = [String:String]()
var gcmTokens = [String:String]()
let UDID = UIDevice.currentDevice().identifierForVendor!.UUIDString
var cameFromHome = true

var shortDate : String {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "MM/dd/yy"
    return dateFormatter.stringFromDate(NSDate())
}

let productionTokenBT = "production_x75kb8hy_69ppkf6h8fqh9cxb"
let sandboxTokenBT = "sandbox_7v37j3pm_9j46c9m8t3mjfwwq"

let productionHerokuURL = "https://sheltered-wave-14675.herokuapp.com/"
let sandboxHerokuURL = "https://hidden-river-58763.herokuapp.com/"

let sandboxFirebase = "https://testravore.firebaseio.com/"
let productionFirebase = "https://liveravore.firebaseio.com/"

var useHeroku = ""
var useBT = ""
var useFirebase = ""

let devStatus = "sandbox"


func getDocumentsURL() -> NSURL {
    let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
    return documentsURL
}

func fileInDocumentsDirectory(filename: String) -> String {
    
    let fileURL = getDocumentsURL().URLByAppendingPathComponent(filename)
    return fileURL.path!
    
}

func loadImageFromPath(path: String) -> UIImage? {
    
    let image = UIImage(contentsOfFile: path)
    
    if image == nil {
        
        print("missing image at: \(path)")
    }
    print("Loading image from path: \(path)") // this is just for you to see the path in case you want to go to the directory, using Finder.
    return image
    
}