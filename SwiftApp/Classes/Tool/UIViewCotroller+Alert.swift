//
//  UIViewCotroller+Alert.swift
//  SwiftApp
//
//  Created by Mjwon on 2017/9/18.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import Foundation
import UIKit
import SCLAlertView


enum AlertType: Int {
    case show = 0
    case load = 1
}

class Alert {
    
    static let shareInstance = Alert()
    
    /**
    var alert = { (showCloseButton:Bool?
                        ) -> SCLAlertView in
        debugPrint(showCloseButton!)
        
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        let alert = SCLAlertView(appearance: appearance)
        
        return alert
    }*/
    
    var result:SCLAlertViewResponder?;
    
    
    func alert(showCloseButton:Bool? = false,showCircularIcon:Bool? = true) -> SCLAlertView {
        
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: showCloseButton!,
            showCircularIcon: showCircularIcon!
        )
        let alert = SCLAlertView(appearance: appearance)
        
        return alert
    }
    
    func show(text:String,duration:TimeInterval? = 1.5) -> Void {
        
        self.alert(showCircularIcon:false).showTitle(
            "",
            subTitle: text,
            style: .info,
            duration: duration!
        )
    }
    
    
    
    func textField(registerClosure:@escaping ((_ user:String,_ pwd:String)->())) -> Void {
        
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        
        let alert = SCLAlertView(appearance: appearance)
        
        let txt = alert.addTextField("请输入用户名")
        let pwd = alert.addTextField("请输入密码")
        
        alert.addButton("注册") {
            registerClosure(txt.text!,pwd.text!)
        }
        
        alert.addButton("取消") {
            debugPrint("---取消---")
        }
        alert.showEdit("注 册", subTitle: "请填写申请信息！")
    }
    
    func load(text:String) -> Void {
        self.result = self.alert().showWait("", subTitle: text)
    }
    
    func hidden() -> Void {
        self.result?.close();
    }
}

extension UIViewController{

    func show(text:String) -> Void {
        
        Alert.shareInstance.show(text: text)
    
    }
    
    func showTextField(registerClosure:@escaping ((_ user:String,_ pwd:String)->())) -> Void {
        
        Alert.shareInstance.textField(registerClosure: { (user, pwd) in
            registerClosure(user,pwd)
        })
        
    }
    
    func load(text:String) -> Void {
        Alert.shareInstance.load(text: text)
    }
    
    func hidden() -> Void {
        Alert.shareInstance.hidden()
    }

}
