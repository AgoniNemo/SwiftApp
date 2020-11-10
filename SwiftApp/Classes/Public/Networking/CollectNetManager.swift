//
//  CollectNetManager.swift
//  SwiftApp
//
//  Created by Mjwon on 2017/12/6.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import UIKit

class CollectNetManager: BaseNetWorking {

    class func collectListRequest(params:[String:String],completionHandler:@escaping (([String:Any]?,Error?)->())) -> Void{
        
        self.post(url: "\(URI_ROOT)/video/collectionList", params: params) { (dict, error) in
            completionHandler(dict,error)
        }
    }
    
    class func collectRequest(params:[String:String],completionHandler:@escaping (([String:Any]?,Error?)->())) -> Void{
        
        self.post(url: "\(URI_ROOT)/video/colState", params: params) { (dict, error) in
            completionHandler(dict,error)
        }
    }
    
}
