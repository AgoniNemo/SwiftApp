//
//  MyVModel.swift
//  SwiftApp
//
//  Created by Nemo on 2017/10/2.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import Foundation

protocol MyVModelDelegate:BaseVModelDelegate {
    
}

protocol MyVModelInterface:BaseVModelInterface {
    
    var delegate: MyVModelDelegate? { get set }
    
    
}

class MyVModel:MyVModelInterface {
    
    weak var delegate: MyVModelDelegate?
    
    private var dataSorce:[[String:String]] = [["name":"我的收藏"],["name":"观看历史"],["name":"个人信息"]]
    
    func loadLate() {
        
    }
    
    func rowModel(row: Int) -> [String:String] {
        
        return self.dataSorce[row]
    }
    
    func indexPathModel(indexPath: IndexPath) -> [String:String] {
        
        return self.dataSorce[indexPath.row]
        
    }
    
    func numberOfRowsInSection(section:Int) -> Int {
        
        return self.dataSorce.count
    }
    
    func loadingMore() {
        
    }

    
}
