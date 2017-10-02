//
//  CategoriesViewController.swift
//  SwiftApp
//
//  Created by Mjwon on 2017/9/13.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import UIKit

class CategoriesViewController: RootViewController{

    let vModel = CategoriesVModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        vModel.loadingMore()
        
        self.view.addSubview(self.collection)
    }
    
    
    lazy var collection: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        
        let radius = (SCREEN_WIDTH-5*3)/2
        layout.itemSize = CGSize.init(width: radius, height: radius+30+10)
        layout.scrollDirection = .vertical
        
        //设置行间距(最小)
        layout.minimumLineSpacing = 5
 
        //设置列间距(最小)
        layout.minimumInteritemSpacing = 0
        
        //设置边距
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 0, 5)
        
        let c = UICollectionView.init(frame: XCGRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGH), collectionViewLayout: layout)
        c.delegate = self
        c.dataSource = self
        c.backgroundColor = UIColor.white
        c.register(CategoriesCell.self, forCellWithReuseIdentifier: "\(CategoriesCell.self)")
        c.showsVerticalScrollIndicator = true
        
        return c
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension CategoriesViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.vModel.numberOfRowsInSection()
    }
    
    //返回UICollectionViewCell视图
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = CategoriesCell.cell(WithCollectionView: collectionView, index: indexPath)
        cell.setModel(model: vModel.rowModel(row: indexPath.row))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let model = vModel.rowModel(row: indexPath.row)
        let vc = CategoriesListViewController()
        vc.searchKey = model.key
        vc.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
