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
        
        return conver;
    }
    
    func insertData(dict:[String:String]) -> Bool {
        
        return self.insertData(ForDict: dict, tableName: tableName);
    }
    
    func getAllData() -> Array<Dictionary<String,Any>> {
        
        return self.getAllDataTableName(order: "order by id", tableName: tableName);
    }
    
    
    func isExistData(ByArray array:[String]) -> Bool {
        return self.isExistDataByArray(array: array, tableName: tableName);
    }
    
    func verifyData(Forkey key:String) -> Bool {
        
        return self.verifyDataWithDict(dict: ["key":key], relationship: [], tableName: tableName);
    }
    
    func updateData(ForDict dict:[String:String]) -> Bool {
        
        return self.updateDataWithDict(dict: dict, condition: ["key"], overlook: ["user"], tableName: tableName);
    }
    
    func updateData(ForArray array:[[String:String]]) -> Bool {
        
        return self.updateDataWithArray(array: array, condition: ["key"], overlook: ["user"], tableName: tableName);
    }
    
    func inquireData(ForDict dict:[String:String]) -> Array<Dictionary<String,Any>> {
        
        return self.inquireData(WithArray: [[dict]], tableName: tableName);
    }
    
    func deleteAll() -> Bool {
        return self.delete(ForTableName: tableName);
    }
    
    
}
