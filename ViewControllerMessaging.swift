import Firebase
var arrayOfMessages = [ObjectMessage]()
import AirshipKit
import Toucan

var whichImage = ""


import UIKit
import Kingfisher

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

// Define the specific path, image name
let imagePath = fileInDocumentsDirectory("person")

class ViewControllerMessaging: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var messageBox: UITextField!
    var replaceGorR = ""
    var messageReceiver = ""
    var messageSender = ""
    var globalGiverId = ""
    var globalReceiverId = ""
    var globalOs = ""

    @IBOutlet weak var receiverImage: UIImageView!
    @IBOutlet weak var giverImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var imagePicker: UIImagePickerController!
    
    var getMessages = Firebase(url: useFirebase+"Messages/")
    
    var Cloudinary:CLCloudinary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadObjects()
        
        Cloudinary = CLCloudinary(url: "cloudinary://178784351611733:YCXhoirSpE72oyokrShYcHM1cfg@do3jsfnn5")
        
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
                
                postToken.childByAutoId().setValue(postTokenObject)
            }
            print("after the false statement")
        }

        
        let tapGiverGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("giverImageTapped:"))
        giverImage.userInteractionEnabled = true
        giverImage.addGestureRecognizer(tapGiverGestureRecognizer)
        
        let tapReceiverGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("receiverImageTapped:"))
        receiverImage.userInteractionEnabled = true
        receiverImage.addGestureRecognizer(tapReceiverGestureRecognizer)
        
        //let image2 = UIImage(named: "person")!
        //saveImage(image2, path: imagePath)
        
        giverImage.image = UIImage(named: "anon")
        receiverImage.image = UIImage(named: "anon")
        
        var tempImage : UIImage
        tempImage = giverImage.image!
        
        let resizedAndMaskedImage = Toucan(image: tempImage).resize(CGSize(width: 70, height: 70), fitMode: Toucan.Resize.FitMode.Crop).image
        
        giverImage.image = resizedAndMaskedImage
        receiverImage.image = resizedAndMaskedImage
        
        print ("before setting images")
        
        
        for (var i=0; i < allBracelets.count; i++){
            if (braceletSelected == allBracelets[i].braceletId){
                if (allBracelets[i].giverId == UDID){
                    globalGiverId = UDID
                    messageSender = UDID
                    
                    let tempImage = UIImage(contentsOfFile: imagePath)!
                    
                    let resizedAndMaskedImage = Toucan(image: tempImage).resize(CGSize(width: 70, height: 70)).maskWithEllipse().image
                    
                    giverImage.image = resizedAndMaskedImage
                    
                    
                    for profile : ObjectProfilePic in allPics {
                        if profile.userId == allBracelets[i].receiverId {
                            print("inside if")
                            globalReceiverId = profile.userId
                            messageReceiver = profile.userId
                            receiverImage.kf_setImageWithURL(NSURL(string: profile.url)!)
                            
                            print ("heeeeeee")
                            
                            var tempImage : UIImage
                            
                            if receiverImage.image != nil{
                                
                                tempImage = receiverImage.image!
                                let resizedAndMaskedImage = Toucan(image: tempImage).resize(CGSize(width: 70, height: 70)).maskWithEllipse().image
                                
                                receiverImage.image = resizedAndMaskedImage
                            }
                            
                            print ("22")
                            
                       
                            
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
                    
                    let tempImage = UIImage(contentsOfFile: imagePath)!
                    
                    let resizedAndMaskedImage = Toucan(image: tempImage).resize(CGSize(width: 70, height: 70)).maskWithEllipse().image
                    
                    receiverImage.image = resizedAndMaskedImage
                    
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
        
          print("after all images")
        

        
        self.tableView.rowHeight = 25
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Bordered, target: self, action: "back:")
        self.navigationItem.leftBarButtonItem = newBackButton;
        // Do any additional setup after loading the view.
        
      
        print("before end")
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
                
                self.giverImage.image = UIImage(named: "anon")
                
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
            
/*
            imagePicker =  UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .Camera

            presentViewController(imagePicker, animated: true, completion: nil)
*/
        }
        
        else {
            whichImage = braceletChosen.receiverId
            
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
            
            /*
            imagePicker =  UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .Camera
            
            presentViewController(imagePicker, animated: true, completion: nil)
            */
            
        }
            
        else {
            whichImage = braceletChosen.giverId
            
            performSegueWithIdentifier("goToFullImage", sender: self)
        }
        
    /*print("Receiver Image Tapped")
        if braceletChosen.receiverId == UDID {
            replaceGorR = "receiver"
            imagePicker =  UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .Camera
            
            presentViewController(imagePicker, animated: true, completion: nil)
        }
        
        else {
            //LARGE IMAGEVIEW
            performSegueWithIdentifier("goToFullImage", sender: self)
        }
*/
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        
        //let image2 = UIImage(named: "person")!
        //saveImage(info[UIImagePickerControllerOriginalImage] as? UIImage, path: imagePath)
        
        let image2 = info[UIImagePickerControllerOriginalImage] as! UIImage
        saveImage(image2, path: imagePath)
        
        //Toucan(image: portraitImage).resize(CGSize(width: 500, height: 500), fitMode: Toucan.Resize.FitMode.Crop).image
        
        //let resizedAndMaskedImage = Toucan(image: image2).resize(CGSize(width: 70, height: 70)).maskWithEllipse().image
        
        let resizedAndMaskedImage = Toucan(image: image2).resize(CGSize(width: 30, height: 30), fitMode: Toucan.Resize.FitMode.Crop).image
        
        //let resizedImage = Toucan(image: image2).resize(CGSize(width: 70, height: 70))
        //var resizedAndMaskedImage2 = Toucan.maskWithEllipse(resizedImage)
        //let resizedAndMaskedImage = Toucan(image: resizedAndMaskedImage2).image
        
        
        if replaceGorR == "giver"{
             //giverImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage}
            giverImage.image = resizedAndMaskedImage}
        
        if replaceGorR == "receiver"{
            receiverImage.image = resizedAndMaskedImage}
      
        if let jpegData = UIImageJPEGRepresentation(image2, 80) {
            jpegData.writeToFile(imagePath, atomically: true)
        }
        
    }
    
    func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func back(sender: UIBarButtonItem) {
        // Perform your custom actions
        // ...
        // Go back to the previous ViewController
        arrayOfMessages.removeAll()
        getMessages.removeAllObservers()
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        return arrayOfMessages.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Default")
        print("before question")
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
        
        print("after question")
        
        return cell
    }
    
    
    
    func downloadObjects(){
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
    
    func saveImage (image: UIImage, path: String ) -> Bool{
        
        let pngImageData = UIImagePNGRepresentation(image)
        //let jpgImageData = UIImageJPEGRepresentation(image, 1.0)   // if you want to save as JPEG
        let result = pngImageData!.writeToFile(path, atomically: true)
        
        
        //let orientedImage = UIImage(CGImage: image.CGImage, scale: 1, orientation: image.imageOrientation)!
        
        let forUpload = UIImagePNGRepresentation(image) as NSData!
        let uploader = CLUploader(Cloudinary, delegate: nil)
        
        let transformationsSmallPic = CLTransformation()
        let transformationsLargePic = CLTransformation()
        //transformations.setWidthWithInt(70)
        //transformations.setHeightWithInt(70)
        transformationsSmallPic.param("width", value: 70)
        transformationsSmallPic.param("height", value: 70)
        transformationsSmallPic.param("crop" , value: "fill")
        //transformations.param("angle", value: 90)
        
        print("Image Orientation is \(image.imageOrientation.rawValue)")
        
        if image.imageOrientation.rawValue == 3 {
            transformationsSmallPic.param("angle", value: 90)
            transformationsLargePic.param("angle", value: 90)
        }
        
        if image.imageOrientation.rawValue == 2 {
            transformationsSmallPic.param("angle", value: 270)
            transformationsLargePic.param("angle", value: 270)
        }
        
        if image.imageOrientation.rawValue == 1 {
            transformationsSmallPic.param("angle", value: 180)
            transformationsLargePic.param("angle", value: 180)
        }
        
        uploader.upload(forUpload, options: ["public_id":UDID, "transformation":transformationsSmallPic],
            withCompletion:onCloudinaryCompletion, andProgress:onCloudinaryProgress)
        
        uploader.upload(forUpload, options: ["public_id":"\(UDID)full", "transformation":transformationsLargePic],
            withCompletion:onCloudinaryCompletion, andProgress:onCloudinaryProgress)
        
 
        return result
        
    }
    
    func onCloudinaryCompletion(successResult:[NSObject : AnyObject]!, errorResult:String!, code:Int, idContext:AnyObject!) {
        let fileId = successResult["public_id"] as! String
        let url = successResult["url"] as! String
        let versionInt = successResult["version"] as! Int
        let version = String(versionInt)
        

        print("File ID: \(fileId)")
        print("URL: \(url)")
        //uploadDetailsToServer(fileId)
        
        
        let postPics = Firebase(url: "\(useFirebase)Users/ProfilePics/\(UDID)")
        
        print("after post pics")
        
        postPics.observeEventType(.Value, withBlock: { snap in
            if snap.value is NSNull {
                
                var postFirstPics = [String : String]()
                
                if fileId == UDID {
                    postFirstPics = ["userId" : UDID, "fullPhotoUrl" : "Updating", "fullPhotoVersion" : "Updating", "url" : url, "urlVersion" : version]
                }
                
                if fileId == "\(UDID)full" {
                     postFirstPics = ["userId" : UDID, "fullPhotoUrl" : url, "fullPhotoVersion" : version, "url" : "Updating", "urlVersion" : "Updating"]
                }
                
                postPics.setValue(postFirstPics)
                
            }
            
            else {
                
                print("inside else statement")
                var postNextPics = [String : String]()
                
                if fileId == UDID {
                    
                    print ("Inside UDID")
                    
                    postNextPics = ["url" : url, "urlVersion" : version]
                    postPics.updateChildValues(postNextPics)
                    
                    //let url = ["url" : url]
                    //let version = ["urlVersion" : version]
                    
                    //postPics.updateChildValues(url)
                    //postPics.updateChildValues(version)
                }
                
                if fileId == "\(UDID)full" {
                    
                    print ("Inside UDIDfull")
                    postNextPics = ["fullPhotoUrl" : url, "fullPhotoVersion" : version]
                    postPics.updateChildValues(postNextPics)
                    
                    //let url = ["\(url)full" : url]
                    //let version = ["\(version)full" : version]
                    
                    //postPics.updateChildValues(url)
                    //postPics.updateChildValues(version)
                }
            }
        })
    }
    
    func onCloudinaryProgress(bytesWritten:Int, totalBytesWritten:Int, totalBytesExpectedToWrite:Int, idContext:AnyObject!) {
        //do any progress update you may need
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
        
        
        
        sendPush(message)
        
    }
    
    func sendPush(message: String) {

         print("Message Sender: \(messageSender)")
         print("Message Receiver: \(messageReceiver)")
        
        SendPush.methodToTest(message, messageReceiverId: messageReceiver, title: braceletSelected, type: "message", braceletId: braceletSelected)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
}
