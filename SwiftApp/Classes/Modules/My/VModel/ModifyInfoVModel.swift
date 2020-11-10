//
//  ModifyInfoVModel.swift
//  SwiftApp
//
//  Created by Mjwon on 2017/10/12.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import Foundation

@objc protocol ModifyInfoVModelDelegate{
    func requestSuccess()
    func alertInfo(text:String)
}

private protocol ModifyInfoVModelInterface {
    
    var delegate: ModifyInfoVModelDelegate? { get set }
    
}

class ModifyInfoVModel:ModifyInfoVModelInterface {
    
    weak var delegate: ModifyInfoVModelDelegate?
    
    private var text: String = ""
    private var password: String = ""
    
    func textDidChange(text: String) {
        self.text = text
    }
    
    func passwordDidChange(text: String) {
        password = text
    }
    
    func modifyInformation(type:Int) -> Void {
        let model = UserModel.shareInstance
        let types = ["name","sex","age","phoneNumber"]
        
        let params:[String:String] = [
            "user":model.user,
            "token":model.token,
            types[type]:text
        ]
        
        UserInfoModifyManager.modifyInfoRequest(params: params) { [weak self](dict, err) in
            
            if err != nil{
                XLogLine(err as Any)
                self?.delegate?.alertInfo(text: "修改失败!")
            }else{
                XLogLine(dict as Any)
                
                guard let dic:[String:Any] = dict else{
                    XLogLine("---出错---")
                    self?.delegate?.alertInfo(text: "修改失败!")
                    return
                }
                
                if dic["code"] as! String != "0" {
                    self?.delegate?.alertInfo(text: dic["message"] as! String)
                    return
                }
                
                let result:String = (self?.text)!
                
                switch type {
                case 0:
                    model.name = result
                case 1:
                    model.sex = result
                case 2:
                    model.age = result
                case 3:
                    model.phoneNumber = result
                default:
                    XLogLine("未知修改")
                }
                let b = model.save()
                XLogLine("保存情况：\(b)")
                self?.delegate?.requestSuccess()
                
            }
        }
        
    }
    
    func modifyPassword() -> Void {
        
        let model = UserModel.shareInstance
        
        let params:[String:String] = [
            "user":model.user,
            "token":model.token,
            "newPassword":password,
            "password":text
        ]
        
        UserInfoModifyManager.modifyPasswordRequest(params: params) { [weak self](dict, err) in
            if err != nil{
                XLogLine(err as Any)
                self?.delegate?.alertInfo(text: "修改失败!")
            }else{
                XLogLine(dict as Any)
                
                guard let dic:[String:Any] = dict else{
                    XLogLine("---出错---")
                    self?.delegate?.alertInfo(text: "修改失败!")
                    return
                }
                
                if dic["code"] as! String != "0" {
                    self?.delegate?.alertInfo(text: dic["message"] as! String)
                    return
                }
                
                guard let d:[String:String] = dic["data"] as? [String : String] else{
                    self?.delegate?.alertInfo(text: "返回数据失败!")
                    return
                }
                
                guard let token:String = d["token"] else{
                    XLogLine("---token出错---")
                    self?.delegate?.alertInfo(text: "修改失败!")
                    return
                }
                
                model.token = token
                let b = model.save()                
                if b == true{
                    self?.delegate?.requestSuccess()
                }else{
                    self?.delegate?.alertInfo(text: "保存用户消息失败!")
                }
            }
        }
    }
    
}
