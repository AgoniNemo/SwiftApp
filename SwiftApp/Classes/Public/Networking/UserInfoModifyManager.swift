//
//  UserInfoModifyManager.swift
//  SwiftApp
//
//  Created by Mjwon on 2017/10/12.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import UIKit
import Alamofire

class UserInfoModifyManager: BaseNetWorking {
    
    class func modifyPasswordRequest(params:[String:String],completionHandler:@escaping (([String:Any]?,Error?)->())) -> Void {
        self.post(url: "\(URI_ROOT)/user/modifyPassword", params: params) { (dict, error) in
            completionHandler(dict,error)
        }
    }
    
    class func modifyInfoRequest(params:[String:String],completionHandler:@escaping (([String:Any]?,Error?)->())) -> Void {
        self.post(url: "\(URI_ROOT)/user/modifyInfo", params: params) { (dict, error) in
            completionHandler(dict,error)
        }
    }
    
    class func uploadRequest(multipartData:@escaping ((MultipartFormData)->()),completionHandler:@escaping (([String:Any]?,Error?)->())) -> Void {
        
        self.upload(multipartData: { (data) in
            multipartData(data)
        }, url: "\(URI_ROOT)/file/updateImage") { (dict, error) in
            completionHandler(dict,error)
        }
    }
    
}
