//
//  ViewControllerHowItWorks.swift
//  Ravore2
//
//  Created by Admin on 3/3/16.
//  Copyright © 2016 G LLC. All rights reserved.
//

import UIKit

class ViewControllerHowItWorks: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: {})
    }

}
