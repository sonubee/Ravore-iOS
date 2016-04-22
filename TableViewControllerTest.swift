//
//  TableViewControllerTest.swift
//  Ravore2
//
//  Created by Admin on 4/20/16.
//  Copyright © 2016 G LLC. All rights reserved.
//

var totalBeads = 0

var cartMap: [String:Int] = [
    "Cat":0,
    "Dog":0,
    "Teddy Bear":0,
    "Walrus":0,
    "Octopus":0
]


import UIKit


class TableViewControllerTest: UITableViewController {
  
    var testString: [String] = ["Cat" , "Dog" , "Teddy Bear" , "Walrus" , "Octopus"]
    var logoImage: [UIImage] = [
        UIImage(named: "cat.png")!,
        UIImage(named: "dog.png")!,
        UIImage(named: "bear.png")!,
        UIImage(named: "walrus.png")!,
        UIImage(named: "octo.png")!
    ]
    
    var allCarts = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadTableData:", name: "reload", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "addTotalBead:", name: "addBead", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "subtractTotalBead:", name: "subtractBead", object: nil)
        
        cartMap = [
            "Cat":0,
            "Dog":0,
            "Teddy Bear":0,
            "Walrus":0,
            "Octopus":0
        ]
        
        totalBeads = 0

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return testString.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("testReuse", forIndexPath: indexPath) as! TableViewCellTest
        
        print("came to tablview!")
        
        cell.beadName.text = testString[indexPath.row]
        cell.dollarAmount.text = "$1.00"
        cell.cartCount.text = "Cart: \(cell.cartTotal)"
        cell.beadImage.image = logoImage[indexPath.row]
        
        cartMap[testString[indexPath.row]] = cell.cartTotal

        // Configure the cell...
        
        //print(cartMap)

        return cell
    }
    
    func reloadTableData(notification: NSNotification) {tableView.reloadData()}
    
    func addTotalBead(notification: NSNotification) {totalBeads += 1}
    
    func subtractTotalBead(notification: NSNotification) {totalBeads -= 1}
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
