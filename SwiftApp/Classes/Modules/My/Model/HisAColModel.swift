//
//  HisAColModel.swift
//  SwiftApp
//
//  Created by Nemo on 2017/10/7.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import UIKit

class HisAColModel{

    
    var time:String = ""
    var video:VideoModel?
    
    
    init(dict: [String : Any]) {
        
        self.video = VideoModel.init(dict: dict)
        if self.video != nil {
            self.time = dict["watchTime"]! as! String
        }
        
    }

    func update(_ d:[String:String]) -> Bool {
        var dict:[String:String] = Dictionary.init()
        
        for value in d.enumerated() {
            dict[value.element.key] = value.element.value
        }
        
        dict["videoId"] = (self.video?.id)!
        
       return DatabaseHelper.sharedInstance.videoMager.updateData(ForDict: dict)
    }
    
    func deleteHistory() -> Bool {
        
        let array = DatabaseHelper.sharedInstance.videoMager.inquireData(ForDict: ["videoId":(self.video?.id)!])
        
        if array.count > 0 {
           let dict = array.first
            
            if dict?["collect"] == "0"{
                let dict = ["videoId":(self.video?.id)!]
                return DatabaseHelper.sharedInstance.videoMager.delete(array:[dict],dict:dict)
            }
        }
        
        return self.update(["history":"0"])
    }
    
    func deleteCollect() -> Bool {
        
        return self.update(["collect":"0"])
    }
    
    class func deleteAllCollect() -> Bool {
        
        return DatabaseHelper.sharedInstance.videoMager.updateData(ForDict: ["collect":"0"], [[["user":UserModel.shareInstance.user]]], ["user"])
    }
    
    class func allCollect() -> [[String:Any]] {
        
        return DatabaseHelper.sharedInstance.videoMager.getCollectData()
    }
    
    class func allHistory() -> [[String:Any]] {
        
        return DatabaseHelper.sharedInstance.videoMager.getHistoryData()
    }
    
    /// -MARK:删除
    @discardableResult
    class func delete() -> Bool {
        
        return DatabaseHelper.sharedInstance.videoMager.delete(array: [[["history":"0"]],"and",[["collect":"0"]]], dict: [:])
    }
    
    @discardableResult
    func collect() -> Bool {
        
        let a:Bool = (self.video?.save(false))!
        
        return a
    }
    
}
