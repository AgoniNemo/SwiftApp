//
//  MyInfoModel.swift
//  SwiftApp
//
//  Created by Nemo on 2017/10/8.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import Foundation


class MyInfoModel {

    var head:String = ""
    
    var end:String = ""
    
    var url:String = ""
    
    
    
    init(dict:[String:String]) {
        
        guard dict.count > 0 else {
            assertionFailure("dict 不能为空！")
            return
        }
        
        self.head = dict["head"]!
        
        self.end = dict["end"]!
        
        self.url = dict["url"]!
    }
    
    
}
