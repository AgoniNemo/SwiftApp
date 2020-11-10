//
//  HomeViewController.swift
//  SwiftApp
//
//  Created by Mjwon on 2017/9/13.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import UIKit


class HomeViewController: RootViewController{

    var vModel = HomeVModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        vModel.delegate = self;

        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 5) {
            self.vModel.updateCollect()
        }
        
        self.alertload()
        
        self.view.addSubview(self.tabView)
        //self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)

        self.navigationController?.navigationBar.isTranslucent = false

        self.tabView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }

        refresh()
        vModel.loadLate()

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
   
    func refresh() -> Void {
        XLogLine("刷新。。。")
        self.tabView.addPullToRefresh {
            [weak self] in
            XLogLine("es_加载最新！\(String(describing: self))")
            self?.vModel.loadLate()
            
        }
        
        self.tabView.addInfiniteScrolling {
            [weak self] in
            XLogLine("es_加载更多")
            self?.vModel.loadingMore()
        }
    }
    
    func reloadData() {
        XLogLine("----reloadData----")
        self.hidden()
        self.tabView.es.stopLoadingMore()
        self.tabView.es.stopPullToRefresh(ignoreDate: true)
        self.tabView.reloadData()
        
    }

    
    
     lazy var tabView:UITableView = {
    
        let t = UITableView.init()
        t.delegate = self;
        t.dataSource = self;
        t.rowHeight = 270
        t.showsVerticalScrollIndicator = false
        t.separatorStyle = .none
        return t
        
    }()

    
    deinit {
        XLogLine(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension HomeViewController:HomeVModelDelegate{
    
    func alertload() {
        self.load(text: "数据加载中...")
    }
    
    func alertInfo(text: String) {
        self.show(text: text)
        self.tabView.stopLoadingMore()
    }
    
    func noMoreData() {
        self.show(text: "已经没有更多数据了！")
        self.tabView.stopPullToRefresh(ignoreDate: true, ignoreFooter: false)
    }
    
    func skipLogin() {
        self.tabView.stopLoadingMore()
        let l = LoginViewController()
        l.isBack = true
        self.present(l, animated: false) {
            
        }
    }
}

extension HomeViewController:UITableViewDelegate,UITableViewDataSource{

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = HomeCell.cell(WithTableView: tableView)
        
        cell.setModel(model: vModel.indexPathModel(indexPath: indexPath))
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let model = vModel.indexPathModel(indexPath: indexPath)
        
        if model.hls == false {
            skipViewCotroller(model)
        }else{
            skipHLSViewCotroller(model)
        }
    }
    
    func skipHLSViewCotroller(_ model:VideoModel) -> Void {
        let h = HLSViewController()
        h.model = model
        h.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(h, animated: true)
    }
    
    func skipViewCotroller(_ model:VideoModel) -> Void {
        let p = PlayViewController()
        p.model = model
        p.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(p, animated: true)
    }

}
