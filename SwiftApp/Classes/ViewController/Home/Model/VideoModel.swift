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

    
    init(dict:[String:String]) {
        
        guard dict.count > 0 else {
            return
        }
        
        self.title = dict["title"]!
        self.views = dict["views"]!
        self.duration = dict["duration"]!
        self.playPath = dict["playPath"]!
        self.symbol = dict["symbol"]!
        self.hls = Bool(dict["hls"]!)!
        self.icon = dict["icon"]!
        self.category = dict["category"]!
        self.rating = dict["rating"]!
    }
    
    
}
