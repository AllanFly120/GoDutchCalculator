//
//  PurchaseInfoCell.swift
//  ApartmentCalculator
//
//  Created by 郑杨平 on 9/4/16.
//  Copyright © 2016 AllanZheng. All rights reserved.
//

import Foundation
import UIKit

class PurchaseInfoCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var inputField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
