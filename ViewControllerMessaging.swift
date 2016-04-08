import Firebase
import AirshipKit
import Toucan
import UIKit
import Kingfisher

var arrayOfMessages = [ObjectMessage]()
var whichImage = ""
let imagePath = fileInDocumentsDirectory("anon")

class ViewControllerMessaging: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var messageBox: UITextField!
    var replaceGorR = ""
    var messageReceiver = ""
    var messageSender = ""
    var globalGiverId = ""
    var globalReceiverId = ""
    var globalOs = ""
    var imagePicker: UIImagePickerController!
    var getMessages = Firebase(url: useFirebase+"Messages/")
    
  

    @IBOutlet weak var receiverImage: UIImageView!
    @IBOutlet weak var giverImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadObjects()
        finalPostOfTokenToServer()
        setup()
        setupImages()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayOfMessages.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Default")

        cell.textLabel?.text = arrayOfMessages[indexPath.row].message
        cell.backgroundColor = UIColor.blackColor()
        
        cell.textLabel?.font = UIFont.boldSystemFontOfSize(13)
        
        for bracelet : ObjectBracelet in allBracelets {
            if (bracelet.braceletId == braceletSelected){
                if (arrayOfMessages[indexPath.row].sender == bracelet.giverId){
                    cell.textLabel!.textColor = UIColor.greenColor()
                }
                    
                else {
                    cell.textLabel!.textColor = UIColor.cyanColor()
                    cell.textLabel!.textAlignment = NSTextAlignment.Right
                }
            }
        }
        
        return cell
    }
    
    

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
 
        let resizedAndMaskedImage = Toucan(image: image).resize(CGSize(width: 30, height: 30), fitMode: Toucan.Resize.FitMode.Crop).image
        
        if replaceGorR == "giver"{giverImage.image = resizedAndMaskedImage}
        
        if replaceGorR == "receiver"{receiverImage.image = resizedAndMaskedImage}
        
        if let jpegData = UIImageJPEGRepresentation(image, 80) {jpegData.writeToFile(imagePath, atomically: true)}
        
        UploadImage().uploadToCloudinary(image)
        
        
    }
    
    @IBAction func sendMessage(sender: UIButton) {
        self.messageBox.resignFirstResponder()
        var message: String
        message=String(messageBox.text!)
        
        let baseURL = Firebase(url:useFirebase+"Messages")
        let braceletRef = baseURL.childByAppendingPath(braceletSelected)
        
        let theMessage = ["braceletId": braceletSelected, "date" : shortDate, "message" : message, "sender" : UDID, "timestamp" : shortDate]
        
        braceletRef.childByAutoId().setValue(theMessage)
        messageBox.text = ""
        
        //Sending Push Here
        SendPush.methodToTest(message, messageReceiverId: messageReceiver, title: braceletSelected, type: "message", braceletId: braceletSelected)
        
    }
    
    func back(sender: UIBarButtonItem) {
        // Perform your custom actions
        // ...
        // Go back to the previous ViewController
        arrayOfMessages.removeAll()
        getMessages.removeAllObservers()
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func giverImageTapped(img: AnyObject)
    {
        
        print("Giver Image Tapped")
        
        if braceletChosen.giverId == UDID {
            replaceGorR = "giver"
            
            // create the alert
            let alert = UIAlertController(title: "Photo Options!", message: "Please Select From Below", preferredStyle: UIAlertControllerStyle.Alert)
            
            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: "View Photo", style: UIAlertActionStyle.Default, handler: { action in
                whichImage = UDID
                self.performSegueWithIdentifier("goToFullImage", sender: self)
            }))
            
            alert.addAction(UIAlertAction(title: "Delete Photo", style: UIAlertActionStyle.Default, handler: { action in
                whichImage = UDID
                
                UploadImage().uploadToCloudinary(UIImage(named: "anon")!)
                
            }))
            
            alert.addAction(UIAlertAction(title: "Choose from Library", style: UIAlertActionStyle.Default, handler: { action in
                //self.imagePicker.allowsEditing = false
                self.imagePicker =  UIImagePickerController()
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = .PhotoLibrary
                
                self.presentViewController(self.imagePicker, animated: true, completion: nil)
                
            }))
            
            alert.addAction(UIAlertAction(title: "New Photo", style: UIAlertActionStyle.Default, handler: { action in
                
                // do something like...
                self.imagePicker =  UIImagePickerController()
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = .Camera
                
                self.presentViewController(self.imagePicker, animated: true, completion: nil)
                
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
            
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        }
            
        else {
            
            whichImage = braceletChosen.giverId
            
            print("Bracelet Chosen: \(braceletChosen.braceletId)")
            print("-----------Bracelet Receiver: \(braceletChosen.receiverId)")
            
            performSegueWithIdentifier("goToFullImage", sender: self)
        }
    }
    
    
    func receiverImageTapped(img: AnyObject)
    {
        
        print("Receiver Image Tapped")
        
        if braceletChosen.receiverId == UDID {
            replaceGorR = "receiver"
            
            // create the alert
            let alert = UIAlertController(title: "Photo Options!", message: "Please Select From Below", preferredStyle: UIAlertControllerStyle.Alert)
            
            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: "View Photo", style: UIAlertActionStyle.Default, handler: { action in
                whichImage = UDID
                self.performSegueWithIdentifier("goToFullImage", sender: self)
            }))
            
            alert.addAction(UIAlertAction(title: "Delete Photo", style: UIAlertActionStyle.Default, handler: { action in
                whichImage = UDID
                
                self.receiverImage.image = UIImage(named: "anon")
                
                UploadImage().uploadToCloudinary(UIImage(named: "anon")!)
                
            }))
            
            alert.addAction(UIAlertAction(title: "Choose from Library", style: UIAlertActionStyle.Default, handler: { action in
                //self.imagePicker.allowsEditing = false
                self.imagePicker =  UIImagePickerController()
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = .PhotoLibrary
                
                self.presentViewController(self.imagePicker, animated: true, completion: nil)
                
            }))
            
            alert.addAction(UIAlertAction(title: "New Photo", style: UIAlertActionStyle.Default, handler: { action in
                
                // do something like...
                self.imagePicker =  UIImagePickerController()
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = .Camera
                
                self.presentViewController(self.imagePicker, animated: true, completion: nil)
                
            }))
            
            // show the alert
            self.presentViewController(alert, animated: true, completion: nil)
            
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
            
            
        }
            
        else {
            whichImage = braceletChosen.receiverId
            
            print("-----------Bracelet Chosen: \(braceletChosen.braceletId)")
            print("-----------Bracelet Giver: \(braceletChosen.giverId)")
            
            
            performSegueWithIdentifier("goToFullImage", sender: self)
        }
    }
 
    
}

