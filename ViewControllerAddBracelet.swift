
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
        
        let segueString = AddGiver().overallProcess(braceletSelected)
        if segueString != "" {
            if segueString == "goToAllMessages" {self.performSegueWithIdentifier("goToMessageFromAdd", sender: self)}
            else {self.performSegueWithIdentifier(segueString, sender: self)}
        }
      
    }
    
    @IBAction func addReceiver(sender: UIButton) {
        braceletSelected = addBraceletField.text!
        self.addBraceletField.resignFirstResponder()
        addBraceletField.text = ""
        
        let segueString = AddReceiver().overallProcess(braceletSelected)
        if segueString != "" {
            
            if segueString == "goToAllMessages" {
                self.performSegueWithIdentifier("goToMessageFromAdd", sender: self)
            }
            
            else {
                self.performSegueWithIdentifier(segueString, sender: self)
            }
        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    

}
