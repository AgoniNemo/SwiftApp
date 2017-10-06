//
//  HistoryVModel.swift
//  SwiftApp
//
//  Created by Nemo on 2017/10/6.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import Foundation

protocol HistoryVModelDelegate:BaseVModelDelegate {
    
}

private protocol HistoryVModelInterface:BaseVModelInterface {
    
    weak var delegate: HistoryVModelDelegate? { get set }
    func loadAll()
}

class HistoryVModel:HistoryVModelInterface {
    
    weak var delegate: HistoryVModelDelegate?
    
    private var dataSorce:[VideoModel] = Array.init()
    
    func loadLate() {
        
    }
    
    func loadAll() {
        let list = DatabaseHelper.sharedInstance.videoMager.getHistoryData()
        for val in list.enumerated() {
            let dict = val.element
            
            let model = VideoModel.init(dict: dict)
            self.dataSorce.append(model)
        }
        debugPrint(list)
        
        self.delegate?.reloadData()
    }
    
    func rowModel(row: Int) -> VideoModel {
        
        return self.dataSorce[row]
    }
    
    func numberOfRowsInSection() -> Int {
        
        return self.dataSorce.count
    }
    
    func loadingMore() {
        
    }
    
    func signOut() {
        
        let b =  DatabaseHelper.sharedInstance.userMager.updateData(ForDict: ["status":"0"])
        
        debugPrint("更新情况:\(b)")
    }
    
}
