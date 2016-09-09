//
//  ViewController.swift
//  ApartmentCalculator
//
//  Created by 郑杨平 on 9/4/16.
//  Copyright © 2016 AllanZheng. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       // self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        self.navigationItem.title = "Inventory"
        let nib = UINib(nibName: "TableViewCell", bundle: NSBundle.mainBundle())
        self.tableView.registerNib(nib, forCellReuseIdentifier: "TableViewCell")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: #selector(tabLeftBtn))
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    func tabLeftBtn() {
        let personalSum = getPersonalSum()
        let alert:UIAlertController =  UIAlertController(title: loadAlertMsg(personalSum), message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        let action: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (a: UIAlertAction) in
            self.navigationController?.popViewControllerAnimated(true)
        })
        alert.addAction(action)
        self.presentViewController(alert, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Inventory.list.count + 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row < Inventory.list.count {
            let cell = tableView.dequeueReusableCellWithIdentifier("TableViewCell") as! TableViewCell
            cell.item = Inventory.list[indexPath.row]
            cell.loadContent()
            return cell
        }
        if indexPath.row == Inventory.list.count {
            let cell = UITableViewCell();
            cell.textLabel?.text = "Total: \(String(sumUp()))"
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let deleteItem = UITableViewRowAction(style: .Normal, title: "Delete", handler: {(action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
            Inventory.list.removeAtIndex(indexPath.row)
            tableView.reloadData()
        })
        return [deleteItem]
    }
    
    func sumUp() -> Double {
        var sum: Double = 0.0
        for item in Inventory.list {
            sum = sum + item.price
        }
        return sum
    }
    
    func getPersonalSum() -> [String : Double] {
        var personalSum = [String : Double]()
        for member in Members.list {
            personalSum[member] = 0.0
        }
        for item in Inventory.list {
            for member in item.owner {
                personalSum[member] = personalSum[member]! + item.price / Double(item.owner.count)
            }
        }
        return personalSum
    }
    
    func loadAlertMsg(personalSum: [String : Double]) -> String {
        var msg = ""
        for (name, sum) in personalSum {
            msg = msg + "\(name): \(sum)\n"
        }
        return msg
    }

}

