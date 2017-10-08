//
//  SettingVModel.swift
//  SwiftApp
//
//  Created by Nemo on 2017/10/4.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import Foundation

protocol SettingVModelDelegate:BaseVModelDelegate {
    
}

protocol SettingVModelInterface:BaseVModelInterface {
    
    weak var delegate: SettingVModelDelegate? { get set }
    func signOut()
}

class SettingVModel:SettingVModelInterface {
    
    weak var delegate: SettingVModelDelegate?
    
    private var dataSorce:[[String:String]] = [["name":"帮助"],["name":"关于我们"]]
    
    func loadLate() {
        
    }
    
    func indexPathModel(indexPath: IndexPath) -> [String:String] {
        
        return self.dataSorce[indexPath.row]
        
    }
    
    func numberOfRowsInSection(section:Int) -> Int {
        
        return self.dataSorce.count
    }
    
    func loadingMore() {
        
    }
    
    func signOut() {
        
        let b =  DatabaseHelper.sharedInstance.userMager.updateData(ForDict: ["status":"0"])
        
        debugPrint("更新情况:\(b)")
    }
    
}
