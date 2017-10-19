//
//  BaseNetWorking.swift
//  SwiftApp
//
//  Created by Mjwon on 2017/9/18.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import Foundation
import Alamofire

class BaseNetWorking {
    
    static let shareInstance = BaseNetWorking()
    private init() {}
}

extension BaseNetWorking {

    class func post(url:String,params:[String:Any],completionHandler:@escaping (([String:Any]?,Error?)->())) -> Void {
        
        Alamofire.request(url, method: .post, parameters: params).responseJSON
            {response in
                switch response.result {
                case .success:
                    if let value = response.result.value as? [String : Any] {
                        completionHandler(value,nil)
                    }
                case .failure(let error):
                    debugPrint("请求出错:\(error)")
                    completionHandler(nil,error)
                }
        }
    }

    class func upload(multipartData:@escaping ((MultipartFormData)->()),url:String,completionHandler:@escaping (([String:Any]?,Error?)->())) -> Void {
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartData(multipartFormData)
        }, to: url) { (encodingResult) in
            
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON(completionHandler: { (response) in
                    if let value = response.result.value as? [String : Any] {
                        completionHandler(value,nil)
                    }
                })
            case .failure(let encodingError):
                debugPrint("请求出错:\(encodingError)")
                completionHandler(nil,encodingError)
            }
        }
    }
    
}
