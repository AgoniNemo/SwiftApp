//
//  UserInformationManager.swift
//  IM
//
//  Created by Mjwon on 2017/7/24.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import UIKit
import FMDB

class UserInformationManager: RootDBManager {

    private let tableName = "userInfo_tabel";
    
    class func userInformationManagerForQueue(queue:FMDatabaseQueue) ->UserInformationManager{
        
        let conver = UserInformationManager.init();
        
        conver.queue = queue;
        
        let b = conver.creatTabelWithKeys(keys: userMagerArray, tableName: conver.tableName)
        
        if b == false {
            XLogLine("创建数据表失败!");
        }
        
        return conver;
    }
    
    
    func insertData(dict:[String:String]) -> Bool {
        
        return self.insertData(ForDict: dict, tableName: tableName);
    }
    
    func getData() -> [String:String] {

        let array = self.inquireData(ForDict: ["status":"1"])
        guard array.count > 0 else {
            
            return [:]
        }
        
        return array.first!
    }
    
    func getAllData() -> [[String:Any]] {
        
        return self.getAllDataTableName(order: "order by id", tableName: tableName);
    }
    
    
    func isExistData(ByArray array:[String]) -> Bool {
        return self.isExistDataByArray(array: array, tableName: tableName);
    }
    
    func verifyData(Forkey key:String) -> Bool {
        
        return self.verifyDataWithDict(dict: ["user":key], relationship: [], tableName: tableName);
    }
    
    func updateData(ForDict dict:[String:String]) -> Bool {
        
        return self.updateDataWithDict(dict: dict, condition: [[["user":UserModel.shareInstance.user]]], overlook: ["user"], tableName: tableName);
    }
    
    // 有点问题先放着
    func updateData(ForArray array:[[String:String]]) -> Bool {
        
        return self.updateDataWithArray(array: array, condition: ["user"], overlook: ["user"], tableName: tableName);
    }
    
    func inquireData(ForDict dict:[String:String]) -> [[String:String]] {
        
        return self.inquireData(WithArray: [[dict]], tableName: tableName);
    }
    
    @discardableResult
    func deleteAll() -> Bool {
        return self.delete(ForTableName: tableName);
    }
    
    
}
