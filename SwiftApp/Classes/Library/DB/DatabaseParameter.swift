//
//  DatabaseParameter.swift
//  IM
//
//  Created by Mjwon on 2017/7/21.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import Foundation

/**
 ** 用户数据表字段
 * user 账号
 * sex 用户性别
 * age 年龄
 * name 名字
 * phoneNumber 用户手机号
 * headPath 头像路径
 * authority 权限
 * token 
 * status 用户的登录状态
 * loginTime 最近的登录时间
 */
let userMagerArray = ["user","name","age","sex","phoneNumber","headPath","authority","token","status","loginTime"]


/**
 ** 用户数据表字段
 * title 影片标题
 * views 观看次数
 * duration 影片时间
 * rating 评分
 * icon 影片图片
 * category 影片分类
 * playPath 播放地址
 * symbol 网站标识符
 * hls 是否为HLS播放协议
 * videoId 影片id
 * collect 是否为收载影片
 * history 是否为历史(一般为1，如果看过了，但是在观看里删除了，就为0)
 * watchTime 观看时间
 */
let videoMagerArray = ["title","views","duration","rating","icon","category","playPath","symbol","hls","videoId","collect","history","watchTime"]

