
import UIKit
import PKHUD
import Firebase
import SplunkMint

class FirstViewController: UIViewController, UITextFieldDelegate {
    
    

    @IBOutlet weak var braceletIdFromLogin: UITextField!
    @IBOutlet weak var howItWorksButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        downloadObjects()
        howItWorksButton.hidden = true
        
       
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        cameFromHome=true
         self.navigationController?.navigationBarHidden = true
        
        address = ""
        beadCount=0
        kandiCount=0
        totalPrice=0
        shippingPrice = 0.35
        subtotalPrice = 0
     
        
        if purchaseMade == true {
            Toast.makeToast("Your order has been placed and will arrive in 5 Days. You can check status on the Order Status Screen").show()
            purchaseMade=false
            
            address = ""
            beadCount=0
            kandiCount=0
            totalPrice=0
            shippingPrice = 0.35
            subtotalPrice = 0
        }
    }
    
    @IBAction func giverLogin(sender: UIButton) {
        self.braceletIdFromLogin.resignFirstResponder()
        braceletSelected=String(braceletIdFromLogin.text!)
        braceletIdFromLogin.text = ""
        
        let segueString = AddGiver().overallProcess(braceletSelected)
        if segueString != "" {
            self.performSegueWithIdentifier(segueString, sender: self)
        }
    
    }
    
    @IBAction func receiverLogin(sender: UIButton) {
        self.braceletIdFromLogin.resignFirstResponder()
        braceletSelected = braceletIdFromLogin.text!
        braceletIdFromLogin.text = ""
        
        let segueString = AddReceiver().overallProcess(braceletSelected)
        if segueString != "" {
            self.performSegueWithIdentifier(segueString, sender: self)
            
        }
       
    }
    
    func setup() {
        
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0;
        
        if let resourceUrl = NSBundle.mainBundle().URLForResource("apns-dev-cert", withExtension: "p12") {
            if NSFileManager.defaultManager().fileExistsAtPath(resourceUrl.path!) {
            }
        }
        
        Localytics.tagEvent("iOS Localytics")
        Localytics.setCustomerId(UDID)
        
        if (devStatus == "sandbox"){
            useHeroku = productionHerokuURL
            useBT = sandboxTokenBT
            useFirebase = sandboxFirebase
            //useFirebase = productionFirebase
        }
        
        if (devStatus == "production"){
            useHeroku = productionHerokuURL
            useBT = productionTokenBT
            useFirebase = productionFirebase
        }
        
        self.braceletIdFromLogin.delegate=self
        braceletIdFromLogin.keyboardType = UIKeyboardType.NumberPad
        
        //This will prevent Google Maps from Crashing
        Mint.sharedInstance().disableNetworkMonitoring()
       
        //Initialize the SDK to use the MINT Backend to transport data
        //Will start a new session if one is not active
        Mint.sharedInstance().initAndStartSessionWithAPIKey("ce2dfcb7")
        
        //Initialize the SDK to directly send data to a Splunk instance using
        //HTTP Event Collector
        //Will start a new session if one is not active
        Mint.sharedInstance().initAndStartSessionWithHECUrl("HEC_URL", token: "HEC_TOKEN")
        
        //In order to send NSLOG in crash reports, enableLogging must be set to true
        Mint.sharedInstance().enableLogging(true)
        
        //Set the number of NSLOG messages to send in the crash report
        Mint.sharedInstance().setLogging(20)
        
        //Set some form of userIdentifier for this session
        Mint.sharedInstance().userIdentifier = UDID
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
}