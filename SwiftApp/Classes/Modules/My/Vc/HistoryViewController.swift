//
//  HistoryViewController.swift
//  SwiftApp
//
//  Created by Nemo on 2017/10/6.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import UIKit

class HistoryViewController: RootViewController {

    
    let vModel = HisAColVModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "观看历史"
        
        setBackButton()
        
        vModel.delegate = self
        vModel.loadAll()
        
        self.view.addSubview(self.collection)
        
    }
    
    lazy var collection: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        
        let w = SCREEN_WIDTH/2
        let h = 180/240*w
        layout.itemSize = CGSize.init(width: w, height: h+30+25)
        layout.scrollDirection = .vertical
        
        //设置行间距(最小)
        layout.minimumLineSpacing = 0
        
        //设置列间距(最小)
        layout.minimumInteritemSpacing = 0
        
        //设置边距
//        layout.sectionInset = UIEdgeInsetsMake(5, 5, 0, 5)
        
        let c = UICollectionView.init(frame: XCGRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGH), collectionViewLayout: layout)
        c.delegate = self
        c.dataSource = self
        c.backgroundColor = UIColor.white
        c.register(HistoryCell.self, forCellWithReuseIdentifier: "\(HistoryCell.self)")
        c.showsVerticalScrollIndicator = true
        
        return c
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension HistoryViewController:HisAColVModelDelegate{

    func reloadData() {
        self.collection.reloadData()
    }
    

    func alertInfo(text: String) {
        
        self.show(text: text)
    }
}

extension HistoryViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.vModel.numberOfRowsInSection(section: section)
    }
    
    //返回UICollectionViewCell视图
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = HistoryCell.cell(WithCollectionView: collectionView, index: indexPath)
        cell.setModel(model: vModel.indexPathModel(indexPath: indexPath))
        
        cell.closure = { [weak self]()->() in
            
            self?.showInfo(text: "确定删除 ？", closure: {[weak self]()->() in
                self?.vModel.delete(row: indexPath.row)
            })
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let model = vModel.indexPathModel(indexPath: indexPath)
        let p = PlayViewController()
        p.model = model.video
        p.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(p, animated: true)

    }
    
}
