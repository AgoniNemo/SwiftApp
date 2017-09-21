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
                    completionHandler(nil,error)
                }
        }
    }

}
