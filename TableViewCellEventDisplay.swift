//
//  TableViewCellEventDisplay.swift
//  Ravore2
//
//  Created by Admin on 5/10/16.
//  Copyright © 2016 G LLC. All rights reserved.
//

import UIKit

class TableViewCellEventDisplay: UITableViewCell {
    
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var going: UISwitch!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var eventImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
