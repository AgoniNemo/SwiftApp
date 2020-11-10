//
//  VideoNetManager.swift
//  SwiftApp
//
//  Created by Mjwon on 2017/9/21.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import Foundation


class VideoNetManager: BaseNetWorking {

    class func loadVideoRequest(params:[String:String],completionHandler:@escaping (([String:Any]?,Error?)->())) -> Void{
    
        self.post(url: "\(URI_ROOT)/video/latestVideo", params: params) { (dict, error) in
            completionHandler(dict,error)
        }
    
    }
    

}
