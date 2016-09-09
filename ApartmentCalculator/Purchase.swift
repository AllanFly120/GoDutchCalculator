//
//  Purchase.swift
//  ApartmentCalculator
//
//  Created by 郑杨平 on 9/4/16.
//  Copyright © 2016 AllanZheng. All rights reserved.
//

import Foundation

class Purchase: NSObject {
    var name: String!
    var price: Double!
    var owner: [String]!
    
    override init() {
        super.init()
    }
    
    init(name: String!, price: Double!, owner: [String]!) {
        super.init()
        self.name = name
        self.price = price
        self.owner = owner
    }
}