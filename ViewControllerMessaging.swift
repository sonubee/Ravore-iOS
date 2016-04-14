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
    
    @IBOutlet weak var kandiNumDisplay: UILabel!
    @IBOutlet weak var giverLabel: UILabel!
    @IBOutlet weak var receiverLabel: UILabel!
    @IBOutlet weak var receiverImage: UIImageView!
    @IBOutlet weak var giverImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadObjects()
        finalPostOfTokenToServer()
        setup()
        setupImages()
        setupLabels()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayOfMessages.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat { return UITableViewAutomaticDimension }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Default")

        cell.textLabel?.text = arrayOfMessages[indexPath.row].message
        cell.backgroundColor = UIColor.blackColor()
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
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
        print("///Giver Image Tapped")
        
        if braceletChosen.giverId == UDID {
            replaceGorR = "giver"
            
            print("///before alert")
            
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
            performSegueWithIdentifier("goToFullImage", sender: self)
        }
    }
    
    
    func receiverImageTapped(img: AnyObject)
    {
        
        print("///Receiver Image Tapped")
        
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
            performSegueWithIdentifier("goToFullImage", sender: self)
        }
    }
    
    func setupLabels(){
        if globalGiverId == UDID {giverLabel.text = "You"}
        else {receiverLabel.text = "You"}
    }
    
    
    func setupImages(){
        
        print("beginning of images")
        
        for (var i=0; i < allBracelets.count; i++){
            if (braceletSelected == allBracelets[i].braceletId){
                
                if (allBracelets[i].giverId == UDID){
                    globalGiverId = UDID
                    messageSender = UDID
                    
                    let tempImage : UIImage? = UIImage(contentsOfFile: imagePath)
                    
                    
                    if tempImage != nil {
                        let resizedAndMaskedImage = Toucan(image: tempImage!).resize(CGSize(width: 70, height: 70)).maskWithEllipse().image
                        
                        giverImage.image = resizedAndMaskedImage
                    }
                    
                    if tempImage == nil {
                        print("giver image is nil")
                        let resizedAndMaskedImage = Toucan(image: UIImage(named: "anon")!).resize(CGSize(width: 70, height: 70)).maskWithEllipse().image
                        giverImage.image = resizedAndMaskedImage
                    }
                    
                    for profile : ObjectProfilePic in allPics {
                        if profile.userId == allBracelets[i].receiverId {
                            
                            globalReceiverId = profile.userId
                            messageReceiver = profile.userId
                            receiverImage.kf_setImageWithURL(NSURL(string: profile.url)!)
                            
                            var tempImage : UIImage
                            
                            if receiverImage.image != nil{
                                
                                tempImage = receiverImage.image!
                                let resizedAndMaskedImage = Toucan(image: tempImage).resize(CGSize(width: 70, height: 70)).maskWithEllipse().image
                                
                                receiverImage.image = resizedAndMaskedImage
                            }
                        }
                    }
                    
                    print ("after all but inside loop")
                }
            }
        }
        
        print ("middle of images")
        
        
        for (var i=0; i < allBracelets.count; i++){
            if (braceletSelected == allBracelets[i].braceletId){
                if (allBracelets[i].receiverId == UDID){
                    globalReceiverId = UDID
                    messageSender = UDID
                    //let image = loadImageFromPath(imagePath)
                    //receiverImage.image = image
                    
                    let tempImage : UIImage? = UIImage(contentsOfFile: imagePath)
                    
                    
                    if tempImage != nil {
                        let resizedAndMaskedImage = Toucan(image: tempImage!).resize(CGSize(width: 70, height: 70)).maskWithEllipse().image
                        
                        receiverImage.image = resizedAndMaskedImage
                    }
                    
                    if tempImage == nil {
                        print("receiver image is nil")
                        let resizedAndMaskedImage = Toucan(image: UIImage(named: "anon")!).resize(CGSize(width: 70, height: 70)).maskWithEllipse().image
                        receiverImage.image = resizedAndMaskedImage
                    }
                    
                    for profile : ObjectProfilePic in allPics {
                        if profile.userId == allBracelets[i].giverId {
                            globalGiverId = profile.userId
                            messageReceiver = profile.userId
                            giverImage.kf_setImageWithURL(NSURL(string: profile.url)!)
                            
                            var tempImage : UIImage
                            
                            
                            if giverImage.image != nil {
                                
                                tempImage = giverImage.image!
                                
                                let resizedAndMaskedImage = Toucan(image: tempImage).resize(CGSize(width: 70, height: 70)).maskWithEllipse().image
                                giverImage.image = resizedAndMaskedImage
                            }
                            
                            
                        }
                    }
                }
            }
        }
    }
 
    
}

