//
//  ViewControllerKandi.swift
//  Ravore2
//
//  Created by Admin on 4/29/16.
//  Copyright © 2016 G LLC. All rights reserved.
//

import UIKit
import Firebase

class ViewControllerKandi: UIViewController {

    @IBOutlet weak var storyTextField: UITextField!
    @IBOutlet weak var whereTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var kandiLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kandiLabel.text = "Kandi \(braceletSelected)"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveInfo(sender: UIButton) {
        var kandiUpload = ["story" : storyTextField.text!, "date" : dateTextField.text!, "where" : whereTextField.text!]
        
        if BraceletInfo().amIGiver(braceletSelected){
            Firebase(url:useFirebase).childByAppendingPath("KandiInfo").childByAppendingPath(braceletSelected).childByAppendingPath("giver").setValue(kandiUpload)
        }
            
        else {
            Firebase(url:useFirebase).childByAppendingPath("KandiInfo").childByAppendingPath(braceletSelected).childByAppendingPath("receiver").setValue(kandiUpload)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

}
