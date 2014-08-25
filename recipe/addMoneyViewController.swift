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
        
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
        
        var swipeUp = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(swipeUp)
        
        var swipeDown = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func addAction(outMoney: Bool) {
        
        if outMoney {
            dbManager.insertMoney(self.pocketNum, label: labelValue.text, date: "2014-12-12", money: -(moneyValue.text.toInt()!))
        }else {
            dbManager.insertMoney(self.pocketNum, label: labelValue.text, date: "2014-12-12", money: moneyValue.text.toInt()!)
        }
        
        if self.delegate != nil {
            self.delegate?.endPopAction(self, pocketNum: self.pocketNum)
        }
        
        self.navigationController.popToViewController(self, animated: true)   // Check this code
        self.navigationController.popViewControllerAnimated(true)
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
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                println("Right")
                self.navigationController.popViewControllerAnimated(true)
            case UISwipeGestureRecognizerDirection.Left:
                println("Left")
            case UISwipeGestureRecognizerDirection.Up:
                println("Up")
                UIView.animateWithDuration(1.0,
                    delay: 0.0,
                    options: .CurveEaseInOut,
                    animations: {
                        self.view.frame.offset(dx: 0, dy: -(self.view.frame.height))
                        self.parentViewController.view.backgroundColor = UIColor.whiteColor()
                        println("fucking animation")
                    }, completion: { finished in
                        self.addAction(true)
                })
            case UISwipeGestureRecognizerDirection.Down:
                println("Down")
                UIView.animateWithDuration(1.0,
                    delay: 0.0,
                    options: .CurveEaseInOut,
                    animations: {
                        self.view.frame.offset(dx: 0, dy: self.view.frame.height)
                        self.parentViewController.view.backgroundColor = UIColor.whiteColor()
                        println("fucking animation")
                    }, completion: { finished in
                        self.addAction(true)
                })
            default:
                break
            }
        }
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
