//
//  PurchaseDetailController.swift
//  ApartmentCalculator
//
//  Created by 郑杨平 on 9/4/16.
//  Copyright © 2016 AllanZheng. All rights reserved.
//

import UIKit

class PurchaseDetailController: UITableViewController {
    
    var owner = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func resignFirstResponder() -> Bool {
        return true
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Members.list.count + 3;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("PurchaseInfoCell") as! PurchaseInfoCell
            cell.label.text = "Name:"
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("PurchaseInfoCell") as! PurchaseInfoCell
            cell.label.text = "Price:"
            cell.inputField.keyboardType = .NumbersAndPunctuation
            return cell
        } else if indexPath.row >= 2 && indexPath.row < 2 + Members.list.count {
            let cell = tableView.dequeueReusableCellWithIdentifier("MemberCheckbox")!
            cell.textLabel?.text = Members.list[indexPath.row - 2];
            cell.accessoryType = .None
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("DoneBtnCell")!
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row >= 2 && indexPath.row < 2 + Members.list.count {
            let selectedCell = tableView.cellForRowAtIndexPath(indexPath)!
            let memberIndex = indexPath.row - 2
            if self.owner.contains(Members.list[memberIndex]) {
                self.owner = self.owner.filter({$0 != Members.list[memberIndex]})
                selectedCell.accessoryType = .None
            } else {
                self.owner.append(Members.list[memberIndex])
                selectedCell.accessoryType = .Checkmark
            }
        } else if indexPath.row == 2 + Members.list.count {
            let nameCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! PurchaseInfoCell
            let itemName = nameCell.inputField.text
            let priceCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0)) as! PurchaseInfoCell
            let itemPriceStr = priceCell.inputField.text
            if itemName == nil || itemPriceStr == nil || self.owner.count == 0 {
                presentAlertWithTitle("some info is blank, please check again!")
            } else {
                Inventory.list.append(Purchase(name: itemName!, price: Double(itemPriceStr!)!, owner: self.owner))
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
    }
    
    func presentAlertWithTitle(msg:String) {
        let alert:UIAlertController =  UIAlertController(title: msg, message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        let action: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (a: UIAlertAction) in
            self.navigationController?.popViewControllerAnimated(true)
        })
        alert.addAction(action)
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
