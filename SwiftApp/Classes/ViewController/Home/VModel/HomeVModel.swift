//
//  HomeVModel.swift
//  SwiftApp
//
//  Created by Mjwon on 2017/9/20.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import Foundation


@objc protocol HomeVModelDelegate {
    
    func alertInfo(text:String)
}

protocol HomeVModelInterface {
    weak var delegate: HomeVModelDelegate? { get set }
    func numberOfRowsInSection() -> Int
    func loading()
    func rowModel(row:Int) -> VideoModel
}


class HomeVModel:HomeVModelInterface {
    
    weak var delegate: HomeVModelDelegate?
    
    var dataSource:[VideoModel] = Array.init();
    
    
    func loading() {
        
    }
    
    func rowModel(row: Int) -> VideoModel {
        return self.dataSource[row]
    }
    
    func numberOfRowsInSection() -> Int {
        return self.dataSource.count
    }
    
}
