//
//  HomeViewController.swift
//  SwiftApp
//
//  Created by Mjwon on 2017/9/13.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import UIKit
import DGElasticPullToRefresh
import ESPullToRefresh

class HomeViewController: RootViewController,UITableViewDelegate,UITableViewDataSource,HomeVModelDelegate{

    var vModle = HomeVModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        vModle.delegate = self;
        self.alertload()
        vModle.loadingMore()
        
        self.view.addSubview(self.tabView)

        refresh()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    func alertload() {
        self.load(text: "数据加载中...")
    }
    
    func alertInfo(text: String) {
        self.hidden()
        self.show(text: text)
    }
    func refresh() -> Void {
        
        self.tabView.es_addPullToRefresh {
            [unowned self] in
            self.vModle.loadLate()
            self.tabView.es_stopPullToRefresh(ignoreDate: true)
            /// Set ignore footer or not
            self.tabView.es_stopPullToRefresh(ignoreDate: true, ignoreFooter: false)
        }
        
        self.tabView.es_addInfiniteScrolling {
            [unowned self] in
            debugPrint("es_addInfiniteScrolling")
            self.vModle.loadingMore()
        }
    }
    
    func reloadData() {
        self.hidden()
        self.tabView.es_stopLoadingMore()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let model = vModle.rowModel(row: indexPath.row)
        
        if model.hls == false {
            skipViewCotroller(model)
        }else{
            skipHLSViewCotroller(model)
        }
    }
    
    func skipHLSViewCotroller(_ model:VideoModel) -> Void {
        let h = HLSViewController()
        h.model = model
//        h.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(h, animated: true)
    }
    
    func skipViewCotroller(_ model:VideoModel) -> Void {
        let p = PlayViewController()
        p.model = model
        p.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(p, animated: true)
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
