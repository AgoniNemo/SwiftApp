//
//  CategoriesNetManager.swift
//  SwiftApp
//
//  Created by Nemo on 2017/10/1.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import UIKit

class CategoriesNetManager: BaseNetWorking {

    class func sortQueryRequest(params:[String:Any],completionHandler:@escaping (([String:Any]?,Error?)->())) -> Void {
        
        self.post(url: "\(URI_ROOT)/video/sortQuery", params: params) { (dict, error) in
            completionHandler(dict,error)
        }
    }
    
}
