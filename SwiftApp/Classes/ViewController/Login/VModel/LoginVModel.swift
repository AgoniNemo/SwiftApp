//
//  LoginVModel.swift
//  SwiftApp
//
//  Created by Mjwon on 2017/9/19.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import Foundation
import UIKit


@objc protocol LoginVModelDelegate {
    
    func alertInfo(text:String)
    func loginSuccess()
}

protocol ViewModelInterface {
    weak var delegate: LoginVModelDelegate? { get set }
    
    func userNameDidChange(text:String?)
    func passwordDidChange(text:String?)
    func login()
    func register(user:String,pwd:String,invitationCode:String)
}


public class LoginVModel:ViewModelInterface{

    weak var delegate: LoginVModelDelegate?
    
    private var usernameValid = false
    private var passwordValid = false
    private var userName: String = ""
    private var password: String = ""
    
    func userNameDidChange(text: String? = "") {
        userName = text!
    }
    
    func passwordDidChange(text: String? = "") {
        password = text!
    }
    
    func register(user:String,pwd:String,
                  invitationCode:String) {
        var code = invitationCode
        if code.characters.count == 0 {
            code = "TVRnM013UVdkdmJtbE9aVzF2TVRVd056YzRNREk1Tmc9PQ=="
        }
        let para:[String:Any] = [
            "user":user,
            "password":pwd,
            "invitationCode":code
        ]
        
        LoginNetManager.registerRequest(params: para) { [weak self](dict, err) in
            if err != nil{
                self?.delegate?.alertInfo(text: "注册失败!")
            }else{
                debugPrint(dict as Any)
                
                guard let dic:[String:Any] = dict else{
                    debugPrint("---出错---")
                    self?.delegate?.alertInfo(text: "数据为空!")
                    return
                }
                
                if dic["code"] as! String != "0" {
                    self?.delegate?.alertInfo(text: dic["message"] as! String)
                    return
                }
                
                guard let d:[String:String] = dic["data"] as? [String : String] else{
                    debugPrint("---出错---")
                    self?.delegate?.alertInfo(text: "注册失败!")
                    return
                }
                
                
                let b = UserModel.shareInstance.model(dict: d).save()
                if b == true{
                    self?.delegate?.loginSuccess()
                }else{
                    self?.delegate?.alertInfo(text: "保存用户消息失败!")
                }
            }
        }
    }
    
    func login() {
        
        let para = [
            "user":userName,
            "password":password
        ]
        debugPrint(para)
        LoginNetManager.loginRequest(params: para) {[weak self] (dict, err) in
            if err != nil{
                debugPrint(err as Any)
                self?.delegate?.alertInfo(text: "登录失败!")
            }else{
                debugPrint(dict as Any)
                
                guard let dic:[String:Any] = dict else{
                    debugPrint("---出错---")
                    self?.delegate?.alertInfo(text: "数据为空!")
                    return
                }
                
                if dic["code"] as? String != "0" {
                    self?.delegate?.alertInfo(text: dic["message"] as! String)
                    return
                }
                
                guard let d:[String:String] = dic["data"] as? Dictionary else{
                    debugPrint("---出错---")
                    self?.delegate?.alertInfo(text: "登录失败!")
                    return
                }
                
                let b = UserModel.shareInstance.model(dict: d).save()
                if b == true{
                    self?.delegate?.loginSuccess()
                }else{
                    self?.delegate?.alertInfo(text: "保存用户消息失败!")
                }
            }
        }
    }

}
