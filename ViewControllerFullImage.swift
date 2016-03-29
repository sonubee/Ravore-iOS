//
//  ViewControllerFullImage.swift
//  Ravore2
//
//  Created by Admin on 3/3/16.
//  Copyright © 2016 G LLC. All rights reserved.
//

import UIKit
import Toucan
import Kingfisher

class ViewControllerFullImage: UIViewController {

    @IBOutlet weak var fullImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
   /*
        for userPic : ObjectProfilePic in allPics {
            if userPic.userId == whichImage{
                fullImage.kf_setImageWithURL(NSURL(string: userPic.fullPhotoUrl)!)
            }
        }
        */
        
        if whichImage == UDID {
            
            //let tempImage = UIImage(contentsOfFile: imagePath)!
            
            //let resizedAndMaskedImage = Toucan(image: tempImage).resize(CGSize(width: 70, height: 70)).maskWithEllipse().image
            
            fullImage.image = UIImage(contentsOfFile: imagePath)!
        }
        
        else {
            
            for userPic : ObjectProfilePic in allPics {
                if userPic.userId == whichImage{
                    print("found mach!!!!!!")
                    fullImage.kf_setImageWithURL(NSURL(string: userPic.fullPhotoUrl)!)
                }
            }
            
        }
        
        /*
        if braceletChosen.giverId == UDID {
            for userPic : ObjectProfilePic in allPics {
                if userPic.userId == braceletChosen.receiverId{
                   fullImage.kf_setImageWithURL(NSURL(string: userPic.fullPhotoUrl)!)
                }
            }
            
        }
        
        if braceletChosen.receiverId == UDID {
            for userPic : ObjectProfilePic in allPics {
                if userPic.userId == braceletChosen.giverId{
                    fullImage.kf_setImageWithURL(NSURL(string: userPic.fullPhotoUrl)!)
                }
            }
            
        }
        // Do any additional setup after loading the view.
*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
