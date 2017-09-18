//
//  LoginNetManager.swift
//  SwiftApp
//
//  Created by Mjwon on 2017/9/18.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import Foundation

class LoginNetManager: BaseNetWorking {
    
    class func loginRequest(params:[String:Any],completionHandler:@escaping (([String:Any]?,Error?)->())) -> Void {
        
        self.post(url: "", params: params) { (dict, error) in
            completionHandler(dict,error)
        }
    }
    
}
