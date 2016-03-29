
var totalPrice = 0.00
var orderScreen = ""
var beadCount = 0
var kandiCount = 0
var shippingPrice = 0.0
var subtotalPrice = 0


class SecondViewController: UIViewController {
    

    
    @IBOutlet weak var ravoreBeadImage: UIImageView!
    @IBOutlet weak var kandiBraceletImage: UIImageView!
    
    @IBOutlet weak var subtotal: UILabel!
    @IBOutlet weak var shipping: UILabel!
    @IBOutlet weak var total: UILabel!
    
    @IBOutlet weak var kandiCart: UILabel!
    @IBOutlet weak var beadCart: UILabel!
    @IBOutlet weak var clearButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = false
               
        subtotal.text = "$0"
        shipping.text = "$0"
        total.text = "$0"
        
        //clearButtonOutlet.hidden=true
        
        
        let tapRavoreBeadImageRecognizer = UITapGestureRecognizer(target:self, action:Selector("ravoreBeadTapped:"))
        ravoreBeadImage.userInteractionEnabled = true
        ravoreBeadImage.addGestureRecognizer(tapRavoreBeadImageRecognizer)
        
        let tapKandiImageRecognizer = UITapGestureRecognizer(target:self, action:Selector("kandiTapped:"))
        kandiBraceletImage.userInteractionEnabled = true
        kandiBraceletImage.addGestureRecognizer(tapKandiImageRecognizer)
    }
    
    func ravoreBeadTapped(img: AnyObject) {
        print("tapped bead")
        orderScreen = "bead"
        performSegueWithIdentifier("goToLargeImage", sender: self)
    }
    
    func kandiTapped (img: AnyObject) {
        print("tapped kandi")
        orderScreen = "kandi"
        performSegueWithIdentifier("goToLargeImage", sender: self)
    }
    
    override func viewDidAppear(animated: Bool) {
        cameFromHome = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: {})
    }
    
    @IBAction func addRavoreBead(sender: UIButton) {
        
        if beadCount == 0 && kandiCount == 0 {
            shippingPrice = 0.30
        }
        
        beadCount++
        subtotalPrice += 3
        shippingPrice += 0.15
        totalPrice = Double(subtotalPrice) + shippingPrice
        subtotal.text = "$" + String(subtotalPrice)
        shipping.text = "$" + String.localizedStringWithFormat("%.2f %@", shippingPrice, "")
        //total.text = "$" + String(totalPrice)
        total.text = "$" + String.localizedStringWithFormat("%.2f %@", totalPrice, "")
        beadCart.text = "Cart: " + String(beadCount)
        
        //clearButtonOutlet.hidden=false
        
    }

    @IBAction func removeBead(sender: UIButton) {
        
        if beadCount == 1 && kandiCount == 0 {
            beadCount--
            subtotalPrice = 0
            shippingPrice = 0
        }
            
        else if beadCount == 0 && kandiCount == 0 {
            shippingPrice = 0
            totalPrice=0
            subtotalPrice=0
        }
        
        else if beadCount > 0 {
            beadCount--
            subtotalPrice -= 3
            shippingPrice -= 0.15
        }
        
        totalPrice = Double(subtotalPrice) + shippingPrice
       
        
        subtotal.text = "$" + String(subtotalPrice)
        shipping.text = "$" + String.localizedStringWithFormat("%.2f %@", shippingPrice, "")
        //total.text = "$" + String(totalPrice)
        total.text = "$" + String.localizedStringWithFormat("%.2f %@", totalPrice, "")
        beadCart.text = "Cart: " + String(beadCount)

     
    }
    @IBAction func addKandiBracelet(sender: UIButton) {
        
        if beadCount == 0 && kandiCount == 0 {
            shippingPrice = 0.30
        }
        
        kandiCount++
        subtotalPrice += 5
        shippingPrice += 0.35
        totalPrice = Double(subtotalPrice) + shippingPrice
        subtotal.text = "$" + String(subtotalPrice)
        shipping.text = "$" + String.localizedStringWithFormat("%.2f %@", shippingPrice, "")
        //total.text = "$" + String(totalPrice)
        total.text = "$" + String.localizedStringWithFormat("%.2f %@", totalPrice, "")
        kandiCart.text = "Cart: " + String(kandiCount)
        
        //clearButtonOutlet.hidden=false
      
    }
    
    @IBAction func removeKandi(sender: UIButton) {
       
        if kandiCount == 1 && beadCount == 0 {
            kandiCount--
            subtotalPrice = 0
            shippingPrice = 0
        }
            
        else if beadCount == 0 && kandiCount == 0 {
            shippingPrice = 0
            totalPrice=0
            subtotalPrice=0
        }
            
        else if kandiCount > 0 {
            kandiCount--
            subtotalPrice -= 5
            shippingPrice -= 0.35
        }
        
        
        
        totalPrice = Double(subtotalPrice) + shippingPrice
        
        subtotal.text = "$" + String(subtotalPrice)
        shipping.text = "$" + String.localizedStringWithFormat("%.2f %@", shippingPrice, "")
        //total.text = "$" + String(totalPrice)
        total.text = "$" + String.localizedStringWithFormat("%.2f %@", totalPrice, "")
        kandiCart.text = "Cart: " + String(kandiCount)
        
    }
    

   
    @IBAction func clear(sender: UIButton) {
        totalPrice = 0
        shippingPrice = 0.35
        subtotalPrice = 0
        subtotal.text = "$0"
        shipping.text = "$0"
        total.text = "$0"
        beadCart.text = "Cart: 0"
        kandiCart.text = "Cart: 0"
        beadCount=0
        kandiCount=0
    
        
    }
    
    @IBAction func shippingButtonClicked(sender: UIBarButtonItem) {
        if totalPrice < 1 {
            print("less than $1")
            Toast.makeToast("Add something to the cart").show()
        }
        
        else {
            performSegueWithIdentifier("goToShippingScreen", sender: self)
        }
    }
    
    override func didMoveToParentViewController(parent: UIViewController?) {
        if parent == nil {
            //"Back pressed"
            self.navigationController?.navigationBarHidden = true
            print("back press")
        }
    }
}
