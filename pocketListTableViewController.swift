//
//  pocketListTableViewController.swift
//  recipe
//
//  Created by Kyoseung on 8/9/14.
//  Copyright (c) 2014 devfun. All rights reserved.
//

import UIKit

class pocketListTableViewController: UITableViewController {
    
    // var dbManager: CMoneySqliteManager = CMoneySqliteManager()
    var ANum = [Int32]()
    var AStrLabel = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var aTotal = dbManager.selectAtPocket()
        ANum = aTotal.num
        AStrLabel = aTotal.label

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        var addButton = UIBarButtonItem(title: "Add", style: .Done, target: self, action: "addAction:")
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    func addAction(sender: UIButton) {
        // dbManager.insertDB(12333333, label: labelValue.text, date: "2014-12-12", money: 1111)
        var alert = UIAlertView(title: "Add List", message: "제곧내", delegate: self, cancelButtonTitle: "OK")
        alert.alertViewStyle = UIAlertViewStyle.PlainTextInput
        var textField: UITextField = alert.textFieldAtIndex(0)
        textField.keyboardType = UIKeyboardType.Default
        textField.placeholder = "label"
        
        alert.show()
        
        self.navigationController.popViewControllerAnimated(true)
        
    }
    
    func alertView(View: UIAlertView!, clickedButtonAtIndex: Int) {
        dbManager.insertPocket(View.textFieldAtIndex(0).text)
        
        var aTotal = dbManager.selectAtPocket()
        ANum = aTotal.num
        AStrLabel = aTotal.label
        self.tableView.reloadData()
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
        var cell = tableView.dequeueReusableCellWithIdentifier("pocketTable") as? UITableViewCell
        
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "pocketTable")
        }
        
        cell!.textLabel.text = "\(self.ANum[indexPath.row]), \(self.AStrLabel[indexPath.row])"
        
        return cell
    }
    
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!){
        let nextView = self.storyboard.instantiateViewControllerWithIdentifier("moneyTableView") as moneyListTableViewController
        nextView.pocketNum = indexPath.row
        self.navigationController.pushViewController(nextView, animated: true)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
