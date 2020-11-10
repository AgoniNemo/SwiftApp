//
//  CategoriesModel.swift
//  SwiftApp
//
//  Created by Nemo on 2017/10/1.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import Foundation


class CategoriesModel {
    
    var icon:String = ""
    var title:String = ""
    var key:String = ""
    
    
    
    init(dict:[String:String]) {
        
        guard dict.count > 0 else {
            return
        }
        
        self.title = dict["title"]!
        self.icon = dict["icon"]!
        self.key = dict["key"]!
    }

    
}
