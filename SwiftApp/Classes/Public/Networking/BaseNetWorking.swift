//
//  BaseNetWorking.swift
//  SwiftApp
//
//  Created by Mjwon on 2017/9/18.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class BaseNetWorking {
    
    static let shareInstance = BaseNetWorking()
    private init() {}
}

extension BaseNetWorking {

    class func post(url:String,
                    params:[String:String],
                    completionHandler:@escaping (([String:Any]?,Error?)->())) -> Void {

        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoder: JSONParameterEncoder.default).response { response in
                    switch response.result {
                    case .success:
                        if let respJson = try? JSON(data: response.data!) {
                            completionHandler(respJson.dictionaryObject, nil)
                        }else{
                            XLogLine("数据解析出错:\(String(describing: response.response))")
                        }
                    case .failure(let error):
                        XLogLine("请求出错:\(error)")
                        completionHandler(nil,error)
                    }
        }
    }

    class func upload(multipartData:@escaping ((MultipartFormData)->()),
                      url:String,
                      completionHandler:@escaping (([String:Any]?,Error?)->())) -> Void {
        
        AF.upload(multipartFormData: { (multipartFormData) in
            multipartData(multipartFormData)
        }, to: url).uploadProgress { (progress) in
            XLogLine("请求出错:\(progress)")

        }.response { (response) in
            switch response.result {
            case .success(let dataObj):
                //dataObj?.toData()
                XLogLine("请求出错:\(dataObj!)")
                //successClosure(self.dataToDictionary(data: dataObj!)! as [String : AnyObject])

            case .failure(let err):
                print("upload err: \(err)")
            }
        }
        
    }
    
}
