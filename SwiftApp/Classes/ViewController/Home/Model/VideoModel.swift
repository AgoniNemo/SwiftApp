//
//  VideoModel.swift
//  SwiftApp
//
//  Created by Mjwon on 2017/9/20.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import Foundation



class VideoModel {
    
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
            return
        }
        
        self.title = dict["title"]! as! String
        self.views = dict["views"]! as! String
        self.duration = dict["duration"]! as! String
        self.playPath = dict["playPath"]! as! String
        self.symbol = dict["symbol"]! as! String
        self.hls = dict["hls"]! as! Bool
        self.icon = dict["icon"]! as! String
        self.category = dict["category"]! as! String
        self.rating = (dict["rating"] as? String)!
        self.id = dict["id"]! as! String
    }
    
    
}
