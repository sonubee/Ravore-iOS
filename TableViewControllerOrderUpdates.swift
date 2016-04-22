//
//  TableViewControllerOrderUpdates.swift
//  Ravore2
//
//  Created by Admin on 3/28/16.
//  Copyright © 2016 G LLC. All rights reserved.
//

import UIKit

class TableViewControllerOrderUpdates: UITableViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

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
        return allOrders.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("orderStatusRowDetails", forIndexPath: indexPath)
        
        let cell = tableView.dequeueReusableCellWithIdentifier("orderStatusRowDetails") as! TableViewCellOrderStatus

        // Configure the cell...
        
        cell.beadCount.text = "\(allOrders[indexPath.row].beadCount)"
        //cell.totalAmount.text = "Total: $\(allOrders[indexPath.row].totalPrice)"
        cell.totalAmount.text = "Total: $\(String.localizedStringWithFormat("%.2f %@", allOrders[indexPath.row].totalPrice, ""))"
        
        cell.orderStatus.text = "Status: \(allOrders[indexPath.row].status)"
        cell.orderNumber.text = "Order Number: \(allOrders[indexPath.row].orderNumber)"
        
        if beadCount == 0 {
            
            //cell.beadImage.hidden = true
            
            //var imageName = UIImage(named: "bf_color2_70x90")
            //cell.beadImage!.image = imageName
            
            //cell.beadImage.image = UIImage(named: "bf_color2_70x90")
            //cell.beadImage!.image = UIImage(named: "rsz_anon")
        }
        
        if kandiCount == 0 {
            
            //cell.kandiImage.hidden = true
            
            //cell.kandiImage!.image = UIImage(named: "bg_small")
        }
        

        return cell
    }


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
