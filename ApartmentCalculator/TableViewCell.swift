//
//  TableViewCell.swift
//  ApartmentCalculator
//
//  Created by 郑杨平 on 9/4/16.
//  Copyright © 2016 AllanZheng. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var item = Purchase()
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var owners: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadContent() {
        self.price.text = String(item.price)
        self.name.text = item.name
        self.owners.text = ""
        for owner in item.owner {
            self.owners.text = self.owners.text! + owner + " "
        }
    }
    
}
