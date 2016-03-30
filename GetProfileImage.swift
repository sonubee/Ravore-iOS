//
//  GetProfileImage.swift
//  Ravore2
//
//  Created by Admin on 3/29/16.
//  Copyright © 2016 G LLC. All rights reserved.
//

import Foundation
import UIKit
import Toucan

class GetProfileImage {
 /*
    var tempBracelet = ObjectBracelet()
    
    func getGiverImage (braceletId : String) -> UIImageView {

        let image = UIImage(named: "anon")
        let tempImageView = UIImageView(image: image!)
        
        if BraceletInfo().amIGiver(braceletId) {
            let tempImage = UIImage(contentsOfFile: imagePath)!
            
            let resizedAndMaskedImage = Toucan(image: tempImage).resize(CGSize(width: 70, height: 70)).maskWithEllipse().image
            
            
            tempImageView.image = resizedAndMaskedImage
            
            return tempImageView
            //return resizedAndMaskedImage
        }
            
      */
        
        
        
   
        
/*
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
*/
        
        /*
        return tempImageView
        //return UIImage(named: "anon")!
    }
    */
}
