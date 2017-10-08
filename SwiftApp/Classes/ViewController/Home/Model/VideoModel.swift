//
//  VideoModel.swift
//  SwiftApp
//
//  Created by Mjwon on 2017/9/20.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import Foundation



class VideoModel {
    
    private var dict:[String:String] = Dictionary.init()
    
    
    var title:String = "";
    var views:String = "";
    var duration:String = "";
    var rating:String = "";
    var icon:String = "";
    var category:String = "";
    var playPath:String = "";
    var symbol:String = "";
    var hls:Bool = false;
    var id:String = ""
    
    init(dict:[String:Any]) {
        
        guard dict.count > 0 else {
            assertionFailure("video 数据为空！")
            return
        }
        self.anyDict(to: dict)
        
        self.title = self.dict["title"]! 
        self.views = self.dict["views"]!
        self.duration = self.dict["duration"]!
        self.playPath = self.dict["playPath"]!
        self.symbol = self.dict["symbol"]!
        self.hls = (self.dict["hls"]! == "1") ? true : false
        
        self.icon = self.dict["icon"]!
        self.category = self.dict["category"]!
        self.rating = (self.dict["rating"])!
        self.id = self.dict["videoId"]!
    }
    
    
    private func anyDict(to dict:[String:Any]) -> Void {
        
        for dc in dict.enumerated() {
            
            let k = dc.element.key
            let v:String?
            
            if dc.element.value is Bool {
                let b = dc.element.value as! Bool
                v = b ? "1" : "0"
            }else{
                v = dc.element.value as? String
            }
            
            self.dict[k] = v
            
        }
        
    }
    
    @discardableResult
    func save() -> Bool {
        
        self.dict["watchTime"] = Date.stringTimestamp()
        self.dict["history"] = "1"
        
        if DatabaseHelper.sharedInstance.videoMager.verifyData(Forkey: id) {
            var d:[String:String] = Dictionary.init()
            d["watchTime"] = self.dict["watchTime"]
            d["history"] = "1"
            d["videoId"] = self.dict["videoId"]
            
            return DatabaseHelper.sharedInstance.videoMager.updateData(ForDict: d)
        }
        
        self.dict["collect"] = "0"
        
        let b = DatabaseHelper.sharedInstance.videoMager.insertData(dict: self.dict)
        
        return b
        
    }

    func verifyCollect() -> Bool {
        
        let array = DatabaseHelper.sharedInstance.videoMager.inquireData(ForDict: ["videoId":id])
        
        if array.count > 0 {
            let dict = array.first
            
            if dict?["collect"] == "1"{
                return true
            }
        }

        return false
    }
    
    @discardableResult
    func collect(b:Bool) -> Bool {
        
        var d:[String:String] = Dictionary.init()
        d["collect"] = b ? "1" : "0"
        d["videoId"] = self.dict["videoId"]
        
        return DatabaseHelper.sharedInstance.videoMager.updateData(ForDict: d)
        
    }
    
    
}
