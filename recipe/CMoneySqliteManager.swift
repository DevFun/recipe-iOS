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
        var dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        var path = dirPath.stringByAppendingPathComponent("money.db")
        
        println(path)
        //var path = "/Users/Kyoseung/Workspace/application/recipe-iOS/money.db" // Your .sqlite3 path
        
        var result = sqlite3_open(path, &db)
        
        if result != SQLITE_OK {
            sqlite3_close(db)
            println("sqlite3_open error")
        }
        else if result == SQLITE_OK {
            if sqlite3_exec(db, "SELECT * FROM moneyList", nil, nil, &error) != SQLITE_OK {
                sqlite3_exec(db, "CREATE TABLE moneyList (tableNum INTEGER, num INTEGER PRIMARY KEY AUTOINCREMENT, label TEXT, date DATE, money INTEGER);", nil, nil, &error)
                println("sqlite3_exec: create table 1")
            }
            if sqlite3_exec(db, "SELECT * FROM pocketList", nil, nil, &error) != SQLITE_OK {
                sqlite3_exec(db, "CREATE TABLE pocketList (num INTEGER PRIMARY KEY AUTOINCREMENT, label TEXT);", nil, nil, &error)
                println("sqlite3_exec: create table 2")
            }
        }
    }
    
    func selectAtMoney(tableNum: Int) -> (num: [Int32], strLabel: [String], strDate: [String], money: [Int32] ) {
        var state: COpaquePointer = nil
        // var ATableNum = [Int32]()
        var ANum = [Int32]()
        var AStrLabel = [String]()
        var AStrDate = [String]()
        var AMoney = [Int32]()
        
        if sqlite3_prepare_v2(db, "SELECT * FROM moneyList where tableNum = \(tableNum);", -1, &state, nil) != SQLITE_OK {
            println("sqlite3_prepare_v2 error")
            var zero1: Int32 = 0
            var zero2: String = ""
        }
        else {
            while sqlite3_step(state) == SQLITE_ROW {
                // var tableNum = sqlite3_column_int(state, 0)
                var num = sqlite3_column_int(state, 1)
                var label = sqlite3_column_text(state, 2)
                var date = sqlite3_column_text(state, 3)
                var money = sqlite3_column_int(state, 4)
                
                var data_label = NSData(bytes: label, length: 32)
                var str_label = NSString(data: data_label, encoding: NSASCIIStringEncoding)
                
                var data_date = NSData(bytes: date, length: 10)
                var str_date = NSString(data: data_date, encoding: NSASCIIStringEncoding)
                
                ANum.append(num)
                AStrLabel.append(str_label)
                AStrDate.append(str_date)
                AMoney.append(money)
            }
        }
        return (ANum, AStrLabel, AStrDate, AMoney)
    }
    
    func selectAtPocket() -> (num: [Int32], label: [String]) {
        var state: COpaquePointer = nil
        var ANum = [Int32]()
        var AStrLabel = [String]()
        
        if sqlite3_prepare_v2(db, "SELECT * FROM pocketList;", -1, &state, nil) != SQLITE_OK {
            println("sqlite3_prepare_v2 error")
            var zero1: Int32 = 0
            var zero2: String = ""
        }
        else {
            while sqlite3_step(state) == SQLITE_ROW {
                var num = sqlite3_column_int(state, 0)
                var label = sqlite3_column_text(state, 1)
                
                var data_label = NSData(bytes: label, length: 32)
                var str_label = NSString(data: data_label, encoding: NSASCIIStringEncoding)
                ANum.append(num)
                AStrLabel.append(str_label)
            }
        }
        return (ANum, AStrLabel)
    }
    
    func insertMoney(tableNum: Int, label: String, date: String, money: Int){
        if sqlite3_exec(db, "INSERT INTO moneyList(tableNum, label, date , money) values(\(tableNum), '\(label)', '\(date)', \(money));", nil, nil, &error) != SQLITE_OK {
            println("sqlite3_exec: insertMoney error")
        }
    }
    
    func insertPocket(label: String){
        if sqlite3_exec(db, "INSERT INTO pocketList(label) values('\(label)');", nil, nil, &error) != SQLITE_OK {
            println("sqlite3_exec: insertPocket error")
        }
    }
}

var dbManager: CMoneySqliteManager = CMoneySqliteManager()


