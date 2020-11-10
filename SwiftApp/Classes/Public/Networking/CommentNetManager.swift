//
//  CommentNetManager.swift
//  SwiftApp
//
//  Created by Nemo on 2017/10/3.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import UIKit

class CommentNetManager: BaseNetWorking {

    class func commitRequest(params:[String:String],completionHandler:@escaping (([String:Any]?,Error?)->())) -> Void {
        
        self.post(url: "\(URI_ROOT)/comment/commit", params: params) { (dict, error) in
            completionHandler(dict,error)
        }
    }
    
    class func commitListRequest(params:[String:String],completionHandler:@escaping (([String:Any]?,Error?)->())) -> Void {
        
        self.post(url: "\(URI_ROOT)/comment/list", params: params) { (dict, error) in
            completionHandler(dict,error)
        }
    }
    
}
