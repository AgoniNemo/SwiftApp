//
//  PlayVModel.swift
//  SwiftApp
//
//  Created by Nemo on 2017/9/29.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import Foundation

protocol PlayVModelDelegate:BaseVModelDelegate {
    
}

protocol PlayVModelInterface:BaseVModelInterface {
    
    weak var delegate: PlayVModelDelegate? { get set }
    
    func commit(text:String) -> Void
    
}

class PlayVModel: PlayVModelInterface {
    
    weak var delegate: PlayVModelDelegate?
    
    private var dataSorce:[ReplyModel] = []
    
    func loadLate() {
        
    }
    
    func rowModel(row: Int) -> ReplyModel {
        
        return self.dataSorce[row]
    }
    
    func numberOfRowsInSection() -> Int {
        return self.dataSorce.count
    }
    
    func commit(text: String) {
        let model =  ReplyModel.init()
        model.duration = Date.timeStampToString(timeStamp: "\(Date.intTimestamp())")
        model.content = "\(text)"
        model.username = "昵称"
        self.dataSorce.append(model)
        
        self.delegate?.reloadData()
    }
    
    func loadingMore() {
        
        for i in 0...10 {
            let model =  ReplyModel.init()
            model.duration = "2017年10月19日"
            model.content = "这是回复内容\(i)"
            model.username = "昵称"
            self.dataSorce.append(model)
        }
        
        self.delegate?.reloadData()
    }

}
