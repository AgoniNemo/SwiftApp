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
    
}

class PlayVModel: PlayVModelInterface {
    
    weak var delegate: PlayVModelDelegate?
    
    func loadLate() {
        
    }
    
    func rowModel(row: Int) -> ReplyModel {
        
        let model =  ReplyModel.init()
        model.duration = "2017.10.19"
        model.content = "这是回复内容"
        model.username = "昵称"
        
        return model
    }
    
    func numberOfRowsInSection() -> Int {
        
        return 10
    }

    func loadingMore() {
        
    }

}
