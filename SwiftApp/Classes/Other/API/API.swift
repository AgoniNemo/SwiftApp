//
//  API.swift
//  IM
//
//  Created by Nemo on 2017/2/26.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import Foundation

let DEV_STATE_ONLINE = 0  // 本地开关 1：打开  0：关闭

let URI_ROOT:String = {
    
    if DEV_STATE_ONLINE == 0{
        return "https://xxxserver.herokuapp.com"
    }
    return "http://0.0.0.0:8088"
}()

// 界面隐藏开关
let DEVELOP_TEST = true
