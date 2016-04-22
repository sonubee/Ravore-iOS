
import UIKit
import Braintree
import GoogleMaps
import Firebase

var address = ""
import UIKit

class ViewControllerOrderScreen: UIViewController, BTDropInViewControllerDelegate {
    
    var shipping = 2.45
    var totalPriceNew = 0.0

   var braintreeClient: BTAPIClient!
    
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var suiteApt: UITextField!
    @IBOutlet weak var placesButton: UIButton!
    @IBOutlet weak var amountButtonOutlet: UIButton!
    @IBOutlet weak var receiptOutlet: UITextField!
    @IBOutlet weak var totalBeadsLabel: UILabel!
    @IBOutlet weak var subtotalDisplay: UILabel!
    @IBOutlet weak var shippingDisplay: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        wakeUpServer()
        calculateShippingAndTotal()
        
        print("Total Beads: \(totalBeads)")
        
        totalBeadsLabel.text = "Total Beads: \(totalBeads)"
        subtotalDisplay.text = "Subtotal: $\(totalBeads).00"
        shippingDisplay.text = "Shipping: $\(String.localizedStringWithFormat("%.2f %@", shipping, ""))"
        amountButtonOutlet.setTitle(("$"+String.localizedStringWithFormat("%.2f %@", totalPriceNew, "")), forState: UIControlState.Normal)

    }
    
    func calculateShippingAndTotal(){
        shipping = 2.45 + (Double(totalBeads) * 0.05)
        
        totalPriceNew = Double(totalBeads) + shipping
        
        print("total price = \(totalPriceNew)")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dropInViewController(viewController: BTDropInViewController, didSucceedWithTokenization paymentMethodNonce: BTPaymentMethodNonce){
        //Toast.makeToast("Your order has been placed and will arrive in 5 Days").show()
        purchaseMade = true
        // Send payment method nonce to your server for processing
        putOrderOnFirebase()
        
        postNonceToServer(paymentMethodNonce.nonce)
        
        sendEmailToGurinder()
        
        dismissViewControllerAnimated(true, completion: nil)
        //navigationController?.popViewControllerAnimated(true)
        navigationController?.popToRootViewControllerAnimated(true)
        //self.presentingViewController?.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        
        if devStatus == "production"{
            SendServerRequest.sendRequest("\(useHeroku)OrderMadeEmail", body: "orderAmount=\(totalPrice)")}
        
    }
    
    func dropInViewControllerDidCancel(viewController: BTDropInViewController){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func userDidCancelPayment() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func postNonceToServer(paymentMethodNonce: String) {
        
        let sendBody = "payment_method_nonce=\(paymentMethodNonce)&email=\(receiptOutlet.text!)&amount=\(totalPriceNew)&devProd=\(devStatus)"
        
        SendServerRequest.sendRequest("\(useHeroku)checkout", body: sendBody)
        
        print("went to checkout")
        
    }
    
    @IBAction func makePurchase(sender: UIButton) {
        let name = fullName.text!
        let suiteA = suiteApt.text!
        
        if name == "" {
            Toast.makeToast("Please Enter Your Name").show()
        }
            
        else if address == "" {
            Toast.makeToast("Please Enter Your Address").show()
        }
            
        else {
            print(name, address, suiteA)
            
            self.fullName.resignFirstResponder()
            self.suiteApt.resignFirstResponder()
            
            braintreeClient = BTAPIClient(authorization: useBT)
            
            let dropInViewController = BTDropInViewController(APIClient: braintreeClient)
            
            dropInViewController.delegate = self
            
            dropInViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(
                barButtonSystemItem: UIBarButtonSystemItem.Cancel,
                target: self, action: "userDidCancelPayment")
            let navigationController = UINavigationController(rootViewController: dropInViewController)
            presentViewController(navigationController, animated: true, completion: nil)
        }
        
    }
    
    func sendEmailToGurinder(){
        
        if devStatus == "production"{
            SendServerRequest.sendRequest("\(useHeroku)OrderMadeEmail", body: "orderAmount=\(totalPrice)")}
    }
    
    func wakeUpServer () {SendServerRequest.sendRequest("\(useHeroku)hello", body: "")}
    
    
 
    @IBAction func places(sender: UIButton) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        self.presentViewController(autocompleteController, animated: true, completion: nil)
    }
    
    func updateButton(){
        placesButton.setTitle(address, forState: UIControlState.Normal)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func back(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: {})
    }
    
    func putOrderOnFirebase () {
        
        var orderNumber : String {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MMddyyhhmmss"
            return dateFormatter.stringFromDate(NSDate())
        }
        
        
        let postNewOrder = ["address": address, "email": receiptOutlet.text!, "fullName" : fullName.text! , "suiteApt" : suiteApt.text!, "totalPrice" : totalPrice, "os" : "iOS", "date" : shortDate, "beadCount" : beadCount, "kandiCount" : kandiCount, "deviceId" : UDID, "orderNumber" : orderNumber, "shippingPrice" : shippingPrice, "status" : "Processing", "subtotalPrice" : subtotalPrice]
        
        let postOrder = Firebase(url:useFirebase+"Orders")
        postOrder.childByAutoId().setValue(postNewOrder)
    
    }
}

extension ViewControllerOrderScreen: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(viewController: GMSAutocompleteViewController, didAutocompleteWithPlace place: GMSPlace) {
        print("Place name: ", place.name)
        print("Place address: ", place.formattedAddress!)
        print("Place attributions: ", place.attributions)
        address = place.formattedAddress!
        updateButton()
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func viewController(viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: NSError) {
        // TODO: handle the error.
        print("Error: ", error.description)
    }
    
    // User canceled the operation.
    func wasCancelled(viewController: GMSAutocompleteViewController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(viewController: GMSAutocompleteViewController) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(viewController: GMSAutocompleteViewController) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }


}
