//
//  TableViewControllerAllMessages.swift
//  Ravore2
//
//  Created by Admin on 3/1/16.
//  Copyright © 2016 G LLC. All rights reserved.
//

import Firebase
import UIKit
import Kingfisher
var purchaseMade = false
import Toucan

class TableViewControllerAllMessages: UITableViewController {
    
    override func viewDidLoad() {
        

        super.viewDidLoad()

        self.tableView.rowHeight = 70.0
        
        cameFromHome=false
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
     
        self.tableView.reloadData()
        
        address = ""
        beadCount=0
        kandiCount=0
        totalPrice=0
        shippingPrice = 0.35
        subtotalPrice = 0
    
        if purchaseMade == true {
            Toast.makeToast("Your order has been placed and will arrive in 5 Days. You can check status on the Order Status Screen").show()
            purchaseMade=false
            
            address = ""
            beadCount=0
            kandiCount=0
            totalPrice=0
            shippingPrice = 0.35
            subtotalPrice = 0
        }
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return registeredBracelets.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
       
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Default")
        cell.textLabel!.text = registeredBracelets[indexPath.row].getBraceletId()
        cell.textLabel!.textColor = UIColor.whiteColor()
        cell.backgroundColor = UIColor.blackColor()
        cell.textLabel?.font = UIFont.boldSystemFontOfSize(13)
        cell.imageView!.image = UIImage(named: "rsz_anon")

        var tempImage : UIImage
        
        print("//1")

        if (registeredBracelets[indexPath.row].giverId == UDID){
            
            print("//2")
            print (allPics.count)
     
            for (var i = 0; i < allPics.count; i++){
                
                print("--\(allPics[i].url)")
                
                if (allPics[i].userId == registeredBracelets[indexPath.row].receiverId){
                    
                    let url = allPics[i].url
                    
                    print("3")
                    if let image = UIImage(named: "placeholder") {
                        
                        print("4.5")
                        
                        cell.imageView?.kf_setImageWithURL(NSURL(string: url)!, placeholderImage: image)
                            
                        print("5")
                    }
                }
            }
        }
        
        if (registeredBracelets[indexPath.row].receiverId == UDID){
      
            for (var i = 0; i < allPics.count; i++){
                if (allPics[i].userId == registeredBracelets[indexPath.row].giverId){
                    
                    let url = allPics[i].url
                    
                    print("ok here2")
                    if let image = UIImage(named: "placeholder") {
                        
                        print("lala")
                        
                        cell.imageView?.kf_setImageWithURL(NSURL(string: url)!, placeholderImage: image)
                        
                        print("ya")
              
                    }
                }
            }
        }
        
        tempImage = cell.imageView!.image!
        
        let resizedAndMaskedImage = Toucan(image: tempImage).resize(CGSize(width: 70, height: 70)).maskWithEllipse().image
        
        print("k")
        
        cell.imageView!.image = resizedAndMaskedImage

        
   
        print("after")
        
        //let resizedAndMaskedImage = Toucan(image: tempImage).resize(CGSize(width: 70, height: 70), fitMode: Toucan.Resize.FitMode.Crop).image
        
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        print ("Selected Row: ", indexPath.row)
        print("Bracelet Selected: ", registeredBracelets[indexPath.row].braceletId)
        braceletSelected=registeredBracelets[indexPath.row].braceletId
        
        braceletChosen = registeredBracelets[indexPath.row]
        
        self.performSegueWithIdentifier("goToMessage", sender: self)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            
            let braceletKey = braceletKeys[registeredBracelets[indexPath.row].getBraceletId()]!
            
            print("Bracelet Key is: \(braceletKey)")
            
            let deleteBracelet = Firebase(url:"\(useFirebase)Bracelets/\(braceletKey)")
            let deleteMessages = Firebase(url:"\(useFirebase)Messages/\(registeredBracelets[indexPath.row].getBraceletId())")
            
            deleteBracelet.removeValue()
            deleteMessages.removeValue()
            registeredBracelets.removeAtIndex(indexPath.row)
            
            Toast.makeToast("Deleted!").show()
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        
        tableView.reloadData()
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
