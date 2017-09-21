//
//  HomeViewController.swift
//  SwiftApp
//
//  Created by Mjwon on 2017/9/13.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import UIKit
import DGElasticPullToRefresh

class HomeViewController: RootViewController,UITableViewDelegate,UITableViewDataSource,HomeVModelDelegate{

    var vModle = HomeVModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        vModle.delegate = self;
        vModle.loadingMore()
        
        self.view.addSubview(self.tabView)

        refresh()
        
    }
    func alertload() {
        self.load(text: "数据加载中...")
    }
    
    func alertInfo(text: String) {
        self.show(text: text)
    }
    func refresh() -> Void {
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor.white
        self.tabView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            self?.vModle.loadLate()
            self?.tabView.dg_stopLoading()
        }, loadingView: loadingView)
        
        self.tabView.dg_setPullToRefreshFillColor(HOMECOLOR)
        self.tabView.dg_setPullToRefreshBackgroundColor(UIColor.white)
    }
    
    func reloadData() {
        self.hidden()
        self.tabView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vModle.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = HomeCell.cell(WithTableView: tableView)
        
        cell.setModel(model: vModle.rowModel(row: indexPath.row))
        
        return cell
        
    }
    
    
    lazy var tabView:UITableView = {
    
        let t = UITableView.init(frame: XCGRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGH))
        
        t.delegate = self;
        t.dataSource = self;
        t.rowHeight = 92
        t.showsVerticalScrollIndicator = false
        return t
        
    }()

    
    deinit {
        self.tabView.dg_removePullToRefresh()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
