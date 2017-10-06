//
//  HistoryViewController.swift
//  SwiftApp
//
//  Created by Nemo on 2017/10/6.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import UIKit

class HistoryViewController: RootViewController {

    
    let vModel = HistoryVModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setBackButton()
        
        vModel.delegate = self
        vModel.loadAll()
        
        self.view.addSubview(self.tableView)
        
    }
    
    lazy var tableView: UITableView = {
        let t = UITableView.init(frame: XCGRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGH), style: .grouped)
        t.delegate = self
        t.dataSource = self
        
        return t
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension HistoryViewController:HistoryVModelDelegate{

    func reloadData() {
        self.tableView.reloadData()
    }
    
    func alertload() {
        
    }

    func alertInfo(text: String) {
        
    }
}

extension HistoryViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell")
        
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "HistoryCell")
        }
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    
}
