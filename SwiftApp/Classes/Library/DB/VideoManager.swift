//
//  VideoManager.swift
//  SwiftApp
//
//  Created by Nemo on 2017/10/6.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import Foundation
import FMDB

class VideoManager: RootDBManager {
    
    private let tableName = "video_tabel";
    
    class func videoManagerForQueue(queue:FMDatabaseQueue) ->VideoManager{
        
        let mager = VideoManager.init();
        
        mager.queue = queue;
        
        let b = mager.creatTabelWithKeys(keys: videoMagerArray, tableName: mager.tableName)
        
        if b == false {
            debugPrint("创建数据表失败!");
        }
        
        return mager;
    }
    
    @discardableResult
    func insertData(dict:[String:String]) -> Bool {
        
        return self.insertData(ForDict: dict, tableName: tableName);
    }
    
    @discardableResult
    func updateData(ForDict dict:[String:String]) -> Bool {
        
        return self.updateDataWithDict(dict: dict, condition: [[["videoId":dict["videoId"]]]], overlook: ["videoId"], tableName: tableName);
    }
    
    @discardableResult
    func updateData(ForDict dict:[String:String],_ condition:[[[String:String]]],_ overlook:[String]) -> Bool {
        
        return self.updateDataWithDict(dict: dict, condition: condition, overlook: overlook, tableName: tableName);
    }
    
    func verifyData(Forkey key:String) -> Bool {
        
        return self.verifyDataWithDict(dict: ["videoId":key], relationship: [], tableName: tableName);
    }
    
    // 有点问题先放着
    @discardableResult
    func updateData(ForArray array:[[String:String]]) -> Bool {
        
        return self.updateDataWithArray(array: array, condition: ["videoId"], overlook: ["videoId"], tableName: tableName);
    }
    
    func getCollectData() -> [[String:Any]] {
        
        return self.getData(condition: "collect = '1'", conditionBack: "", order: "order by watchTime desc", tableName: tableName);
        
    }
    
    func delete(dict:[String:String]) -> Bool {
        
        return self.delete(dict: dict, name: tableName)
    }
    
    func getHistoryData() -> [[String:Any]] {
        
        return self.getData(condition: "history = '1'", conditionBack: "", order: "order by watchTime desc", tableName: tableName);
        
    }

    func inquireData(ForDict dict:[String:String]) -> [[String:String]] {
        
        return self.inquireData(WithArray: [[dict]], tableName: tableName);
    }
    
    
    
}
