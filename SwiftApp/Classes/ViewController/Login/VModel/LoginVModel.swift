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
}


public class LoginVModel:ViewModelInterface{

    weak var delegate: LoginVModelDelegate?
    
    private var usernameValid = false
    private var passwordValid = false
    private var userName: String = ""
    private var password: String = ""
    
    func userNameDidChange(text: String? = "") {
        userName = text!
        debugPrint(userName)
    }
    
    func passwordDidChange(text: String? = "") {

        password = text!
        debugPrint(password)
        
    }
    
    func login() {
        
        let para = [
            "user":userName,
            "password":password
        ]
        
        LoginNetManager.loginRequest(params: para) {[weak self] (dict, err) in
            if err != nil{
                self?.delegate?.alertInfo(text: "登录失败!")
            }else{
                self?.delegate?.loginSuccess()
            }
        }
    }

}
