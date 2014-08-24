//
//  moneyListTableViewController.swift
//  recipe
//
//  Created by Kyoseung on 8/9/14.
//  Copyright (c) 2014 devfun. All rights reserved.
//

import UIKit

class moneyListTableViewController: UITableViewController, addMoneyViewControllerDelegate {
    
    // var dbManager: CMoneySqliteManager = CMoneySqliteManager()
    
    var ANum = [Int32]()
    var AStrLabel = [String]()
    var AStrDate = [String]()
    var AMoney = [Int32]()
    
    var pocketNum = -1
    
    func endPopAction(controller: addMoneyViewController, pocketNum: Int) {
        self.tableInit(pocketNum)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.ANum.count
    }
    
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell = tableView.dequeueReusableCellWithIdentifier("moneyTable") as? UITableViewCell
        
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "moneyTable")
        }
        
        cell!.textLabel.text = "\(self.pocketNum), \(self.ANum[indexPath.row]), \(self.AStrLabel[indexPath.row]), \(self.AStrDate[indexPath.row]), \(self.AMoney[indexPath.row])"
        
        return cell
    }
    
    func tableInit(inputPocketNum: Int) {
        self.pocketNum = inputPocketNum
        var aTotal = dbManager.selectAtMoney(self.pocketNum)
        ANum = aTotal.num
        AStrLabel = aTotal.strLabel
        AStrDate = aTotal.strDate
        AMoney = aTotal.money
        self.tableView.reloadData()
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView!, moveRowAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue!.identifier == "addMoneySegue" {
            var nextView = segue.destinationViewController as addMoneyViewController
            nextView.pocketNum = self.pocketNum
            nextView.delegate = self
        }
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                println("Right")
            case UISwipeGestureRecognizerDirection.Left:
                println("Left")
                performSegueWithIdentifier("addMoneySegue", sender: self)
            case UISwipeGestureRecognizerDirection.Up:
                println("Up")
            case UISwipeGestureRecognizerDirection.Down:
                println("Down")
            default:
                break
            }
        }
    }
}
