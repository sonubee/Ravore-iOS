//
//  TableViewCellOrderStatus.swift
//  Ravore2
//
//  Created by Admin on 3/28/16.
//  Copyright © 2016 G LLC. All rights reserved.
//

import UIKit

class TableViewCellOrderStatus: UITableViewCell {

    @IBOutlet weak var kandiCount: UILabel!
    @IBOutlet weak var beadCount: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var orderStatus: UILabel!
    @IBOutlet weak var beadImage: UIImageView!
    @IBOutlet weak var kandiImage: UIImageView!
    @IBOutlet weak var orderNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
