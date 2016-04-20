//
//  UploadImage.swift
//  Ravore2
//
//  Created by Admin on 3/29/16.
//  Copyright © 2016 G LLC. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class UploadImage {
    
    var smallUploadedAlready = false
    var bigUploadedAlready = false
    
    var Cloudinary:CLCloudinary!
    
    
    func uploadToCloudinary (image : UIImage){
        Cloudinary = CLCloudinary(url: "cloudinary://178784351611733:YCXhoirSpE72oyokrShYcHM1cfg@do3jsfnn5")
        
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
        

    }
    
    
    func onCloudinaryCompletion(successResult:[NSObject : AnyObject]!, errorResult:String!, code:Int, idContext:AnyObject!) {
        let fileId = successResult["public_id"] as! String
        let url = successResult["url"] as! String
        let versionInt = successResult["version"] as! Int
        let version = String(versionInt)
        
        print("***************File ID: \(fileId)")
        print("***************URL: \(url)")
        
        let postPics = Firebase(url: "\(useFirebase)Users/ProfilePics").childByAppendingPath(UDID)
        
        if !bigUploadedAlready || !smallUploadedAlready {
            print("hererererererer")
            postPics.observeSingleEventOfType(.Value, withBlock: { snap in
                
                if snap.value is NSNull {
                    
                    
                    let createEmptyFirst = ["userId" : "NA", "url" : "NA", "urlVersion" : "NA", "fullPhotoUrl" : "NA", "fullPhotoVersion" : "NA"]
                    postPics.setValue(createEmptyFirst)
                    
                    Firebase(url: "\(useFirebase)UserInfo").childByAppendingPath(UDID).childByAppendingPath("ProfilePics").setValue(createEmptyFirst)
                    
                    
                    print("((((((((((((nsnull if")
                    
                    print("0")
                    
                    var postFirstPics = [String : String]()
                    
                    print("0.5")
                    
                    if fileId == UDID {
                        postFirstPics = ["userId" : UDID, "url" : url, "urlVersion" : version]
                    }
                    
                    print("1")
                    
                    if fileId == "\(UDID)full" {
                        postFirstPics = ["userId" : UDID, "fullPhotoUrl" : url, "fullPhotoVersion" : version]
                    }
                    
                    print("2")
                    
                    postPics.updateChildValues(postFirstPics)
                    
                    print("3")
                    
                    Firebase(url: "\(useFirebase)UserInfo").childByAppendingPath(UDID).childByAppendingPath("ProfilePics").updateChildValues(postFirstPics)
                    
                    print ("end if")
                    
                }
                    
                else {
                    
                     print("((((((((((((nsnull else")
                    
                    var postNextPics = [String : String]()
                    
                    if fileId == UDID {
                        
                        print ("Inside UDID-\(useFirebase)")
                        
                        postNextPics = ["url" : url, "urlVersion" : version, "userId" : UDID]
                        postPics.updateChildValues(postNextPics)
                        
                        Firebase(url: "\(useFirebase)UserInfo").childByAppendingPath(UDID).childByAppendingPath("ProfilePics").updateChildValues(postNextPics)
                        
                    }
                    
                    if fileId == "\(UDID)full" {
                        
                        print ("Inside UDIDfull")
                        postNextPics = ["fullPhotoUrl" : url, "fullPhotoVersion" : version]
                        postPics.updateChildValues(postNextPics)
                        
                        Firebase(url: "\(useFirebase)UserInfo").childByAppendingPath(UDID).childByAppendingPath("ProfilePics").updateChildValues(postNextPics)
                    }
                }
            })
        }
        
        if fileId == UDID {
            bigUploadedAlready = true
        }
            
        else if fileId == "\(UDID)full" {
            smallUploadedAlready = true
        }
    }
    
    func onCloudinaryProgress(bytesWritten:Int, totalBytesWritten:Int, totalBytesExpectedToWrite:Int, idContext:AnyObject!) {
        //do any progress update you may need
    }
}