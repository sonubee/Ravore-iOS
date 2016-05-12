//
//  CollectionViewControllerFestivalDetails.swift
//  Ravore2
//
//  Created by Admin on 5/11/16.
//  Copyright © 2016 G LLC. All rights reserved.
//

import UIKit

class CollectionViewControllerFestivalDetails: UICollectionViewController {
    
    var logoImages = [UIImage]()
    var logoText = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoText.append("Pictures")
        logoText.append("World Map")
        logoText.append("Get Tickets")
        logoText.append("See Website")
        logoText.append("Festival Map")
        logoText.append("Get Matched")
        logoText.append("Parties/Gatherings")
        logoText.append("Uploads")
        
        logoImages.append(UIImage(named: "festival_scaled.jpg")!)
        logoImages.append(UIImage(named: "map.jpg")!)
        logoImages.append(UIImage(named: "ticket.png")!)
        logoImages.append(UIImage(named: "web.png")!)
        logoImages.append(UIImage(named: "scaled_festival_map.jpg")!)
        logoImages.append(UIImage(named: "match.jpg")!)
        logoImages.append(UIImage(named: "pre-party_scaled.jpg")!)
        logoImages.append(UIImage(named: "uploads.png")!)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        //self.performSegueWithIdentifier("goToDetails", sender: self)
        
        let tempString = allEvents[indexPath.row].name.stringByReplacingOccurrencesOfString(" ", withString: "+")
        
        if indexPath.row == 0 {
            for event in allEvents {
                print(event.name)
                print(festivalSelected)
                if event.name == festivalSelected {
                    print("Match!!!")
                    UIApplication.sharedApplication().openURL(NSURL(string: "https://www.google.com/search?q=\(tempString)&tbm=isch")!)
                }
            }
        }
        
        if indexPath.row == 2 {
            for event in allEvents {
                print(event.name)
                print(festivalSelected)
                if event.name == festivalSelected {
                    print("Match!!!")
                    UIApplication.sharedApplication().openURL(NSURL(string: event.ticketsSite)!)
                }
            }
        }
        
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return logoText.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionCell", forIndexPath: indexPath) as! CollectionViewCellFestivalDetails
    
        // Configure the cell
        
        cell.layer.borderColor = UIColor.grayColor().CGColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        
        cell.labelCollectionCell.text = logoText[indexPath.row]
        cell.imageCollectionCell.image = logoImages[indexPath.row]
        //MyImageview.contentMode = UIViewContentModeScaleAspectFill;
        //MyImageview.clipsToBounds = YES;
        
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }
*/
    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
        
        print ("Selected")
    
    }
 

}
