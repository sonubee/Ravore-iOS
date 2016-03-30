

import Foundation
import UIKit

extension ViewControllerMessaging {
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
                /*
                self.giverImage.image = UIImage(named: "anon")
                
                let forUpload = UIImagePNGRepresentation(UIImage(named: "anon")!) as NSData!
                let uploader = CLUploader(self.Cloudinary, delegate: nil)
                
                let transformationsSmallPic = CLTransformation()
                
                transformationsSmallPic.param("width", value: 70)
                transformationsSmallPic.param("height", value: 70)
                transformationsSmallPic.param("crop" , value: "fill")
                
                uploader.upload(forUpload, options: ["public_id":UDID, "transformation":transformationsSmallPic],
                    withCompletion:self.onCloudinaryCompletion, andProgress:self.onCloudinaryProgress)
                
                uploader.upload(forUpload, options: ["public_id":"\(UDID)full"],
                    
                    withCompletion:self.onCloudinaryCompletion, andProgress:self.onCloudinaryProgress)
                */
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
                
                UploadImage().uploadToCloudinary(UIImage(named: "anon")!)
                /*
                let forUpload = UIImagePNGRepresentation(UIImage(named: "anon")!) as NSData!
                let uploader = CLUploader(self.Cloudinary, delegate: nil)
                
                let transformationsSmallPic = CLTransformation()
                
                transformationsSmallPic.param("width", value: 70)
                transformationsSmallPic.param("height", value: 70)
                transformationsSmallPic.param("crop" , value: "fill")
                
                uploader.upload(forUpload, options: ["public_id":UDID, "transformation":transformationsSmallPic],
                    withCompletion:self.onCloudinaryCompletion, andProgress:self.onCloudinaryProgress)
                
                uploader.upload(forUpload, options: ["public_id":"\(UDID)full"],
                    
                    withCompletion:self.onCloudinaryCompletion, andProgress:self.onCloudinaryProgress)
                */
                
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
}