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

    func update() -> Bool {
       return DatabaseHelper.sharedInstance.videoMager.updateData(ForDict: ["videoId":(self.video?.id)!,"history":"0"])
    }
    
    func delete() -> Bool {
        
        let array = DatabaseHelper.sharedInstance.videoMager.inquireData(ForDict: ["videoId":(self.video?.id)!])
        
        if array.count > 0 {
           let dict = array.first
            
            if dict?["collect"] == "0"{
                return DatabaseHelper.sharedInstance.videoMager.delete(dict: ["videoId":(self.video?.id)!])
            }
        }
        
        return self.update()
    }
    
    class func allCollect() -> [[String:Any]] {
        
        return DatabaseHelper.sharedInstance.videoMager.getCollectData()
    }
    
    class func allHistory() -> [[String:Any]] {
        
        return DatabaseHelper.sharedInstance.videoMager.getHistoryData()
    }
    
}
