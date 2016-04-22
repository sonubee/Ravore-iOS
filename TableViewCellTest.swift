//
//  TableViewCellTest.swift
//  Ravore2
//
//  Created by Admin on 4/20/16.
//  Copyright © 2016 G LLC. All rights reserved.
//

import UIKit

class TableViewCellTest: UITableViewCell {
    
    var cartTotal:Int = 0

    @IBOutlet weak var beadName: UILabel!
    @IBOutlet weak var cartCount: UILabel!
    @IBOutlet weak var dollarAmount: UILabel!
    
    @IBOutlet weak var beadImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func addBead(sender: UIButton) {
        cartTotal += 1
        print("adding \(cartTotal)")
        NSNotificationCenter.defaultCenter().postNotificationName("reload", object: nil)
        NSNotificationCenter.defaultCenter().postNotificationName("addBead", object: nil)
    }
    
    @IBAction func subtractBead(sender: UIButton) {
        if cartTotal > 0 {
            cartTotal -= 1
            print("subtracting \(cartTotal)")
            NSNotificationCenter.defaultCenter().postNotificationName("reload", object: nil)
            NSNotificationCenter.defaultCenter().postNotificationName("subtractBead", object: nil)
        }        
    }
}
