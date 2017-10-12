//
//  InformationViewController.swift
//  SwiftApp
//
//  Created by Nemo on 2017/10/8.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import UIKit

class InformationViewController: RootViewController {

    
    let vModel = InfoVModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "个人信息"
        setBackButton()
        
        vModel.delegate = self
        vModel.loadingMore()
        
        self.view.addSubview(self.tabView)
    
    }
    
    lazy var tabView: UITableView = {
        let t = UITableView.init(frame: XCGRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGH), style: .grouped)
        t.delegate = self
        t.dataSource = self
        t.tableFooterView = UIView()
        
        return t
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension InformationViewController:InfoVModelDelegate{


    func reloadData() {
        self.tabView.reloadData()
    }
    
    func alertInfo(text: String) {
        
    }
}

extension InformationViewController: UITableViewDelegate,UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return vModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return vModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = MyInfoCell.cell(WithTableView: tabView)
        
        cell.setModel(model:vModel.indexPathModel(indexPath: indexPath))
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    
}
