//
//  ViewControllerAddBracelet.swift
//  Ravore2
//
//  Created by Admin on 3/1/16.
//  Copyright © 2016 G LLC. All rights reserved.
//

import UIKit
import Firebase

class ViewControllerAddBracelet: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var addBraceletField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addBraceletField.delegate=self
        addBraceletField.keyboardType = UIKeyboardType.NumberPad

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addGiver(sender: UIButton) {
        braceletSelected = addBraceletField.text!
        self.addBraceletField.resignFirstResponder()
        addBraceletField.text = ""
        
        var found = false
        for braceletIdFromLogin: ObjectBracelet in allBracelets {
            if (braceletIdFromLogin.braceletId==braceletSelected){
                
                found=true
                
                print("Found Bracelet!")
                
                if (braceletIdFromLogin.giverId == UDID){
                    Toast.makeToast("You Are Already Registered as the Giver!").show()
                    
                }
                    
                else if (braceletIdFromLogin.receiverId == UDID){
                    Toast.makeToast("You Are Registered as the Receiver").show()
                }
                    
                    
                else if (braceletIdFromLogin.giverId == "NA" && braceletIdFromLogin.receiverId == "NA"){
                    var firebaseKey : String!
                    firebaseKey = braceletKeys[braceletSelected]
                    
                    let postGiver = Firebase(url:useFirebase+"Bracelets")
                    postGiver.childByAppendingPath(firebaseKey).childByAppendingPath("giverId").setValue(UDID)
                    postGiver.childByAppendingPath(firebaseKey).childByAppendingPath("dateRegistered").setValue(shortDate)
                    
                    registeredBracelets.append(braceletIdFromLogin)
                
                    
                    self.performSegueWithIdentifier("goToMessageFromAdd", sender: self)
                }
                    
                else if (braceletIdFromLogin.giverId != "NA" && braceletIdFromLogin.receiverId == "NA") {
                    Toast.makeToast("There's already a Giver Registered. Are you the Receiver?").show()
                }
                    
                else if (braceletIdFromLogin.giverId != "NA" && braceletIdFromLogin.receiverId != "NA"){
                    Toast.makeToast("Bracelet Already Taken!").show()
                }
            }
            
        }
        
        if (!found){
            Toast.makeToast("Bracelet Doesn't Exist!").show()
        }
    }
    
    @IBAction func addReceiver(sender: UIButton) {
        braceletSelected = addBraceletField.text!
        self.addBraceletField.resignFirstResponder()
        addBraceletField.text = ""
    
        var found = false
        for braceletIdFromLogin: ObjectBracelet in allBracelets {
            if (braceletIdFromLogin.braceletId==braceletSelected){
                found=true
                print("Found Bracelet!")
                
                
                if (braceletIdFromLogin.receiverId == UDID){
                    Toast.makeToast("You Are Already Registered as the Receiver!").show()
                }
                    
                    
                    
                else if (braceletIdFromLogin.giverId == UDID){
                    print("HERE!@!")
                    Toast.makeToast("You Are Registered as the Giver").show()
                }
                    
                    
                else if (braceletIdFromLogin.giverId != "NA" && braceletIdFromLogin.receiverId == "NA"){
                    var firebaseKey : String!
                    firebaseKey = braceletKeys[braceletSelected]
                    
                    let postReceiver = Firebase(url:useFirebase+"Bracelets")
                    
                    var shortDate : String {
                        let dateFormatter = NSDateFormatter()
                        dateFormatter.dateFormat = "MM/dd/yy"
                        return dateFormatter.stringFromDate(NSDate())
                    }
                    
                    print(shortDate)
                    
                    postReceiver.childByAppendingPath(firebaseKey).childByAppendingPath("receiverId").setValue(UDID)
                    postReceiver.childByAppendingPath(firebaseKey).childByAppendingPath("dateReceived").setValue(shortDate)
                    
                     registeredBracelets.append(braceletIdFromLogin)
                    
                    SendPush.methodToTest("Bracelet \(braceletSelected) Has Been Added!", messageReceiverId: braceletIdFromLogin.giverId, title: braceletSelected, type: "addition", braceletId: braceletSelected)
                    
                    self.performSegueWithIdentifier("goToMessageFromAdd", sender: self)
                }
                    
                else if (braceletIdFromLogin.giverId == "NA" && braceletIdFromLogin.receiverId == "NA") {
                    Toast.makeToast("There's No Giver Registered. Is that you?").show()
                    
                }
                    
                else if (braceletIdFromLogin.giverId != "NA" && braceletIdFromLogin.receiverId != "NA"){
                    Toast.makeToast("Bracelet Already Taken!").show()
                }
            }
            
            
        }
        if (!found){
            Toast.makeToast("Bracelet Doesn't Exist!").show()
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
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
