//
//  ViewControllerFakeModal.swift
//  Ravore2
//
//  Created by Admin on 3/8/16.
//  Copyright © 2016 G LLC. All rights reserved.
//

import UIKit

class ViewControllerFakeModal: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        if cameFromHome {
            performSegueWithIdentifier("goToOrder", sender: self)
        }
            
        else {
            dismissViewControllerAnimated(true, completion: {})
        }
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
