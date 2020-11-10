//
//  LoginNetManager.swift
//  SwiftApp
//
//  Created by Mjwon on 2017/9/18.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import Foundation

class LoginNetManager: BaseNetWorking {
    
    class func loginRequest(params:[String:String],completionHandler:@escaping (([String:Any]?,Error?)->())) -> Void {
        
        self.post(url: "\(URI_ROOT)/user/login", params: params) { (dict, error) in
            completionHandler(dict,error)
        }
    }
    
    class func registerRequest(params:[String:String],completionHandler:@escaping (([String:Any]?,Error?)->())) -> Void {
        
        self.post(url: "\(URI_ROOT)/user/register", params: params) { (dict, error) in
            completionHandler(dict,error)
        }
    }
    
}
