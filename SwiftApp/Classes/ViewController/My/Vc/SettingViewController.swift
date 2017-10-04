//
//  SettingViewController.swift
//  SwiftApp
//
//  Created by Nemo on 2017/10/2.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import UIKit

class SettingViewController: RootViewController {

    let vModel = SettingVModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setBackButton()
        
        self.view.addSubview(self.tableView)
    }
    
    lazy var tableView: UITableView = {
        let t = UITableView.init(frame: XCGRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGH), style: .grouped)
        t.delegate = self
        t.dataSource = self
        
        t.tableFooterView = self.tableFView
        return t
    }()
    
    lazy var tableFView: UIView = {
        let v = UIView.init(frame: XCGRect(0, 0, SCREEN_WIDTH, 50));
        v.backgroundColor = RGBA(r: 239, g: 239, b: 244, a: 1)
        
        let btn = UIButton.init(type: .custom)
        btn.frame = XCGRect(0, v.height!-40, SCREEN_WIDTH , 40)
        btn.setTitle("退出登录", for: .normal)
        btn.setTitleColor(HOMECOLOR, for: .normal)
        btn.backgroundColor = UIColor.white
        btn.addTarget(self, action: #selector(signOut), for: UIControlEvents.touchUpInside);
        v.addSubview(btn)
        
        return v
    }()

    
    
    func signOut() -> Void {
        vModel.signOut()
        let vc = LoginViewController()
        vc.isBack = true
        self.present(vc, animated: false) { 
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension SettingViewController:UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "settingCell")
        
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "settingCell")
        }
        
        cell?.textLabel?.text = vModel.rowModel(row: indexPath.row)["name"]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    

}
