//
//  MyViewController.swift
//  IM
//
//  Created by Nemo on 2016/11/16.
//  Copyright © 2016年 Nemo. All rights reserved.
//

import UIKit

class MyViewController: RootViewController {

    let vModel = MyVModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.tabView)

        setSettingButton()
    }
    
    func setSettingButton() -> Void {
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self;
        let btn = UIButton.init(type: .custom)
        btn.frame = XCGRect(0, 0, 20, 20)
        
        btn.setImage(#imageLiteral(resourceName: "setting"), for: .normal)
        
        btn.addTarget(self, action: #selector(settingAction), for: UIControlEvents.touchUpInside);
        
        let item = UIBarButtonItem.init(customView: btn)
        self.navigationItem.rightBarButtonItem = item;
        
    }
    
    func settingAction()->Void{
        let vc = SettingViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         self.headerView.setImage(url: UserModel.shareInstance.headPath)
    }
    
    lazy var tabView: UITableView = {
        let t = UITableView.init(frame: XCGRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGH), style: .grouped)
        t.delegate = self
        t.dataSource = self
        t.tableFooterView = UIView()
        t.tableHeaderView = self.headerView
        
        return t
    }()
    
    lazy var headerView: GlassEffectView = {
        let h = GlassEffectView.init(frame: XCGRect(0, 0, SCREEN_WIDTH, 180*2))

        return h
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MyViewController: UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return vModel.numberOfRowsInSection(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = MyCell.cell(WithTableView: tabView)
        
        cell.setModel(dict: vModel.rowModel(row: indexPath.row))
        
        return cell
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            skipCol()
        case 1:
            skipHis()
        case 2:
            skipInfo()
        default:
            debugPrint("no viewCotrller")
        }
        
    }
    
    func skipCol() -> Void {
        let vc = MyCollectViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func skipInfo() -> Void {
        let vc = InformationViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func skipHis() -> Void {
        let vc = HistoryViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
