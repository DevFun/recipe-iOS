//
//  addMoneyViewController.swift
//  recipe
//
//  Created by Kyoseung on 8/9/14.
//  Copyright (c) 2014 devfun. All rights reserved.
//

import UIKit

protocol addMoneyViewControllerDelegate{
    func endPopAction(controller: addMoneyViewController, pocketNum: Int)
}


class addMoneyViewController: UIViewController {

    @IBOutlet weak var moneyValue: UITextField!
    @IBOutlet weak var labelValue: UITextField!
    @IBOutlet weak var dateValue: UIDatePicker!
    var pocketNum = -1
    
    var delegate: addMoneyViewControllerDelegate? = nil
    
    // var dbManager: CMoneySqliteManager = CMoneySqliteManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var addButton = UIBarButtonItem(title: "Add", style: .Done, target: self, action: "addAction:")
        self.navigationItem.rightBarButtonItem = addButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func addAction(sender: UIButton) {
        /*
        var beforeView = self.storyboard.instantiateViewControllerWithIdentifier("moneyTableView") as moneyListTableViewController
        beforeView.pocketNum = self.pocketNum
        */
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        dbManager.insertMoney(self.pocketNum, label: labelValue.text, date: dateFormatter.stringFromDate(self.dateValue.date), money: moneyValue.text.toInt()!)
        
        /*
        var aTotal = dbManager.selectAtMoney(beforeView.pocketNum)
        beforeView.ANum = aTotal.num
        beforeView.AStrLabel = aTotal.strLabel
        beforeView.AStrDate = aTotal.strDate
        beforeView.AMoney = aTotal.money
        beforeView.tableView.reloadData()
*/

        // self.presentViewController(beforeView, animated: true, completion: nil)
        // self.navigationController.popViewControllerAnimated(true)
        
        if self.delegate != nil {
            self.delegate?.endPopAction(self, pocketNum: self.pocketNum)
        }
        
        self.navigationController.popToViewController(self, animated: true)   // Check this code
        self.navigationController.popViewControllerAnimated(true)
        
}
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
