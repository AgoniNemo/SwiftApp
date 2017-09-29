//
//  ReplyModel.swift
//  SwiftApp
//
//  Created by Nemo on 2017/9/29.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import Foundation

class ReplyModel {
    
    var username:String = "";
    var duration:String = "";
    var content:String = "";
    var icon:String = "";
    
    
    init() {
        
    }
    
    init(dict:[String:Any]) {
        
        guard dict.count > 0 else {
            return
        }
        
        self.username = dict["username"]! as! String
        self.duration = dict["duration"]! as! String
        self.icon = dict["icon"]! as! String
        self.content = (dict["content"] as? String)!
    }
    
    
}
