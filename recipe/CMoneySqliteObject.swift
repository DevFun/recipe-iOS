//
//  CMoneySqliteObject.swift
//  recipe
//
//  Created by Kyoseung on 8/9/14.
//  Copyright (c) 2014 devfun. All rights reserved.
//

import UIKit
import Foundation

class CMoneySqliteManager: NSObject {
    
    var db: COpaquePointer = nil
    var error: UnsafeMutablePointer<Int8> = nil
    
    override init(){
        var path = "/Users/Kyoseung/Workspace/application/recipe-iOS/money.sqlite3" // Your .sqlite3 path
        
        var result = sqlite3_open(path, &db)
        
        if result != SQLITE_OK {
            sqlite3_close(db)
            println("sqlite3_open error")
        }
        else if result == SQLITE_OK {
            if sqlite3_exec(db, "SELECT * FROM moneyList", nil, nil, &error) != SQLITE_OK {
                sqlite3_exec(db, "CREATE TABLE moneyList (tableNum INTEGER, num INTEGER PRIMARY KEY AUTOINCREMENT, label TEXT, date DATE, money INTEGER);", nil, nil, &error)
                println("sqlite3_exec: create table")
            }
        }
        println("init")
    }
    
    func selectAtDB() -> ( tableNum: [Int32], num: [Int32], strLabel: [String], strDate: [String], money: [Int32] ) {
        var state: COpaquePointer = nil
        var ATableNum = [Int32]()
        var ANum = [Int32]()
        var AStrLabel = [String]()
        var AStrDate = [String]()
        var AMoney = [Int32]()
        
        if sqlite3_prepare_v2(db, "SELECT * FROM moneyList;", -1, &state, nil) != SQLITE_OK {
            println("sqlite3_prepare_v2 error")
            var zero1: Int32 = 0
            var zero2: String = ""
        }
        else {
            while sqlite3_step(state) == SQLITE_ROW {
                var tableNum = sqlite3_column_int(state, 0)
                var num = sqlite3_column_int(state, 1)
                var label = sqlite3_column_text(state, 2)
                var date = sqlite3_column_text(state, 3)
                var money = sqlite3_column_int(state, 4)
                
                var data_label = NSData(bytes: label, length: 32)
                var str_label = NSString(data: data_label, encoding: NSUTF8StringEncoding)
                
                var data_date = NSData(bytes: date, length: 10)
                var str_date = NSString(data: data_date, encoding: NSUTF8StringEncoding)
                
                print(tableNum)
                print(" ")
                print(num)
                print(" ")
                print(str_label)
                print(" ")
                print(str_date)
                print(" ")
                println(money)
                
                ATableNum.append(tableNum)
                ANum.append(num)
                AStrLabel.append(str_label)
                AStrDate.append(str_date)
                AMoney.append(money)
            }
        }
        return (ATableNum, ANum, AStrLabel, AStrDate, AMoney)
    }
    
    func insertDB(tableNum: Int, label: String, date: String, money: Int){
        if sqlite3_exec(db, "INSERT INTO moneyList(tableNum, label, date , money ) values(\(1), '\(label)', '\(date)', \(123123));", nil, nil, &error) != SQLITE_OK {
            println("sqlite3_exec: insert error")
        }
    }
}


