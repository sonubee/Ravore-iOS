//
//  ViewControllerRavoreImage.swift
//  Ravore2
//
//  Created by Admin on 3/8/16.
//  Copyright © 2016 G LLC. All rights reserved.
//

import UIKit

class ViewControllerRavoreImage: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if orderScreen == "bead"{
               imageView!.image = UIImage(named: "bf_color1_280x216")
        }
        
        if orderScreen == "kandi"{
            imageView!.image = UIImage(named: "bg_medium")
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
