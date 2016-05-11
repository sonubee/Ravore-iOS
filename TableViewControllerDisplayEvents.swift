//
//  TableViewControllerDisplayEvents.swift
//  Ravore2
//
//  Created by Admin on 5/10/16.
//  Copyright © 2016 G LLC. All rights reserved.
//

import UIKit

class TableViewControllerDisplayEvents: UITableViewController {
    
    var sidebar: FrostedSidebar!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sidebar = FrostedSidebar(
            itemImages: [
                UIImage(named: "profile")!,
                UIImage(named: "icon")!,
                UIImage(named: "star")!],
            colors: [
                UIColor(red: 240/255, green: 159/255, blue: 254/255, alpha: 1),
                UIColor(red: 255/255, green: 137/255, blue: 167/255, alpha: 1),
                UIColor(red: 126/255, green: 242/255, blue: 195/255, alpha: 1)],
            selectionStyle: .Single)
        
        
        sidebar.actionForIndex[0] = { self.performSegueWithIdentifier("goToProfile", sender: self)}
        
        sidebar.actionForIndex[1] = { self.performSegueWithIdentifier("goToOrderBeads", sender: self) }
        
        sidebar.actionForIndex[2] = { self.performSegueWithIdentifier("goToBracelets", sender: self) }

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
        return allEvents.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("displayEvents", forIndexPath: indexPath) as! TableViewCellEventDisplay

        // Configure the cell...
        
        cell.name.text = allEvents[indexPath.row].name
        cell.location.text = allEvents[indexPath.row].location
        cell.date.text = allEvents[indexPath.row].date
        cell.eventImage.kf_setImageWithURL(NSURL(string: allEvents[indexPath.row].imageUrl)!)

        return cell
    }
    
    @IBAction func menuButton(sender: UIBarButtonItem) {
        sidebar.showInViewController( self, animated: true )
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
