//
//  ModifyInfoViewController.swift
//  SwiftApp
//
//  Created by Mjwon on 2017/10/12.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import UIKit

enum ModifyType:Int {
    case name = 0
    case sex = 1
    case age = 2
    case phoneNumber = 3
    case password = 4
}

class ModifyInfoViewController: RootViewController {

    var model:MyInfoModel?
    
    var type:ModifyType? = .name
    var vModel = ModifyInfoVModel()
    
    typealias Completion = () -> ()
    var closure:Completion?;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = LIGHTCOLOR
        
        setBackButton()
        setRightButton(title: "保存")
        self.title = model?.head
        vModel.delegate = self
        
        if type == .password {
            self.textField.placeholder = "请输入旧密码"
            self.pswField.placeholder = "请输入新密码"
            
        }else{
            self.textField.placeholder = "请输入\(model?.head ?? String())"
        }
        
    }
    
    override func rightAction() {
        self.load(text: "加载中...")
        if type == .password {
            vModel.modifyPassword()
        }else{
            vModel.modifyInformation(type: (type?.rawValue)!)
        }
    }
    
    dynamic func textChanged(field: LineTextField) {
        
        if field == self.textField {
            vModel.textDidChange(text: field.text!)
        }else{
            vModel.passwordDidChange(text: field.text!)
        }
    }
    
    lazy var pswField: LineTextField = {
        let t = LineTextField.init(frame: XCGRect(0, self.textField.maxY!+12, SCREEN_WIDTH, 40))
        t.backgroundColor = UIColor.white
        t.textColor = UIColor.black
        t.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        self.view.addSubview(t)
        return t
    }()
    
    lazy var textField: LineTextField = {
        let t = LineTextField.init(frame: XCGRect(0, 64+12, SCREEN_WIDTH, 40))
        t.backgroundColor = UIColor.white
        t.textColor = UIColor.black
        t.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        self.view.addSubview(t)
        return t
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    deinit {
        debugPrint(self)
    }
    
}

extension ModifyInfoViewController:ModifyInfoVModelDelegate{
    
    func requestSuccess() {
        self.hidden()
        if self.closure != nil{
            self.closure!();
        }
        self.navigationController?.popViewController(animated: true)
    }
        
    func alertInfo(text: String) {
        self.show(text: text)
    }
}
