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
        
        fullImage.contentMode = .ScaleAspectFit
        
        if whichImage == UDID {fullImage.image = UIImage(contentsOfFile: imagePath)!}
            
        else {
            
            for userPic : ObjectProfilePic in allPics {
                if userPic.userId == whichImage{
                    fullImage.kf_setImageWithURL(NSURL(string: userPic.fullPhotoUrl)!)}}
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
