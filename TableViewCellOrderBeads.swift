//
//  TableViewCellOrderBeads.swift
//  Ravore2
//
//  Created by Admin on 4/20/16.
//  Copyright © 2016 G LLC. All rights reserved.
//

import UIKit

class TableViewCellOrderBeads: UITableViewCell {
    
    var cartTotal:Int = 0
    
    @IBOutlet weak var beadImage: UIImageView!
    @IBOutlet weak var beadName: UILabel!
    @IBOutlet weak var cartCount: UILabel!
    @IBOutlet weak var dollarAmount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        print("TableViewCell")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addBead(sender: UIButton) {
        cartTotal += 1
    }

    @IBAction func subtractBead(sender: UIButton) {
        cartTotal -= 1
    }
}
