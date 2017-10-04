//
//  UserModel.swift
//  SwiftApp
//
//  Created by Nemo on 2017/9/17.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import Foundation
import UIKit

class UserModel {
    
    static let shareInstance = UserModel()
    
    private var dic:[String:String]?;
    var isTokenExpire:Bool = false
    
    var user:String = "";
    var sex:String = "";
    var age:String = "";
    var name:String = "";
    
    var phoneNumber:String = "";
    var headPath:String = "";
    /// 权限
    var authority:String = "";
    
    var token:String = "";
    var stutas:Bool = false
    
    
    
    @discardableResult
    func model(dict:[String:String]) -> UserModel {
        
        guard dict.count > 0 else {
            return UserModel.shareInstance
        }
        
        self.dic = dict;
        
        setProperties(dict: dict)
        return UserModel.shareInstance
    }
    
    private init() {
        debugPrint(self)
        let d = DatabaseHelper.sharedInstance.userMager.getData()
        
        guard d.count > 0 else {
            return
        }
        
        setProperties(dict: d)
        self.stutas = true;
        
        guard let logTime = d["loginTime"] else {
            return
        }
        
        self.isTokenExpire = Date.contrastDate(time: logTime)
        
    }
    
    private func setProperties(dict:[String:String]) -> Void{
        
        self.user = dict["user"]!
        self.sex = dict["sex"]!
        self.age = dict["age"]!
        self.name = dict["name"]!
        
        self.phoneNumber = dict["phoneNumber"]!
        self.headPath = dict["headPath"]!
        self.authority = dict["authority"]!
        self.token = dict["token"]!
        
        
    }
    
    public func save() -> Bool {
        guard var d = self.dic else {
            return false
        }
        d["status"] = "1";
        d["loginTime"] = Date.stringTimestamp();
        self.isTokenExpire = false
        self.stutas = true;
        
        if DatabaseHelper.sharedInstance.userMager.verifyData(Forkey: user) {
            return DatabaseHelper.sharedInstance.userMager.updateData(ForDict: d)
        }
        
        return DatabaseHelper.sharedInstance.userMager.insertData(dict: d)
    }
    
}
