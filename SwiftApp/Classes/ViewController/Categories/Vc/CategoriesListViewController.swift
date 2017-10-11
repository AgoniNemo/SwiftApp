//
//  CategoriesListViewController.swift
//  SwiftApp
//
//  Created by Nemo on 2017/10/2.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import UIKit
import ESPullToRefresh

class CategoriesListViewController: RootViewController {

    var searchKey:String = ""
    
    var vModel = CatgrListVModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        
        setBackButton()
        
        vModel.key = searchKey
        vModel.delegate = self;
        self.alertload()
        
        self.view.addSubview(self.tabView)
        
        refresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func refresh() -> Void {
        debugPrint("刷新。。。\(String(describing: self))")
        self.tabView.es_addPullToRefresh {
            [weak self] in
            debugPrint("es_加载最新\(String(describing: self))")
            self?.vModel.loadLate()
            
        }
        
        self.tabView.es_addInfiniteScrolling {
            [weak self] in
            debugPrint("es_加载更多\(String(describing: self))")
            self?.vModel.loadingMore()
        }
    }
    
    lazy var tabView:UITableView = {
        
        let t = UITableView.init(frame: XCGRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGH))
        
        t.delegate = self;
        t.dataSource = self;
        t.rowHeight = 270
        t.showsVerticalScrollIndicator = false
        t.separatorStyle = .none
        
        return t
        
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension CategoriesListViewController:CatgrListVModelDelegate{


    func alertload() {
        self.load(text: "数据加载中...")
    }
    
    func alertInfo(text: String) {
        self.show(text: text)
    }
    
    
    func reloadData() {
        self.hidden()
        self.tabView.es_stopLoadingMore()
        self.tabView.es_stopPullToRefresh(ignoreDate: true)
        self.tabView.reloadData()
    }

}

extension CategoriesListViewController:UITableViewDelegate,UITableViewDataSource{


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
        //        h.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(h, animated: true)
    }
    
    func skipViewCotroller(_ model:VideoModel) -> Void {
        let p = PlayViewController()
        p.model = model
        p.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(p, animated: true)
    }


}
