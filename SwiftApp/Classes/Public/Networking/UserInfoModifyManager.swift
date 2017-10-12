//
//  UserInfoModifyManager.swift
//  SwiftApp
//
//  Created by Mjwon on 2017/10/12.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import UIKit

class UserInfoModifyManager: BaseNetWorking {

    
    class func modifyPasswordRequest(params:[String:Any],completionHandler:@escaping (([String:Any]?,Error?)->())) -> Void {
        self.post(url: "\(URI_ROOT)/user/modifyPassword", params: params) { (dict, error) in
            completionHandler(dict,error)
        }
    }
    
    class func modifyInfoRequest(params:[String:Any],completionHandler:@escaping (([String:Any]?,Error?)->())) -> Void {
        self.post(url: "\(URI_ROOT)/user/modifyInfo", params: params) { (dict, error) in
            completionHandler(dict,error)
        }
    }
    
}
