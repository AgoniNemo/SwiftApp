//
//  InfoVModel.swift
//  SwiftApp
//
//  Created by Nemo on 2017/10/8.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import Foundation

protocol InfoVModelDelegate:BaseVModelDelegate {
    
}

private protocol InfoVModelInterface:BaseVModelInterface {
    
    weak var delegate: InfoVModelDelegate? { get set }

    func numberOfSections() -> Int
}

class InfoVModel:InfoVModelInterface {
    
    weak var delegate: InfoVModelDelegate?
    
    private var dataSorce:[Any] = Array.init()
    
    func loadLate() {
        
    }
    
    func numberOfSections() -> Int {
        
        return self.dataSorce.count
    }
    
    func indexPathModel(indexPath: IndexPath) -> MyInfoModel {
        
        let arry:[MyInfoModel] = self.dataSorce[indexPath.section] as! [MyInfoModel]
        debugPrint(arry.count,indexPath.row)
        return arry[indexPath.row]
        
    }
    
    
    func numberOfRowsInSection(section:Int) -> Int {
        
        let arry:[MyInfoModel] = self.dataSorce[section] as! [MyInfoModel]
        
        return arry.count
    }
    
    func loadingMore() {
        let model = UserModel.shareInstance
        
        let ary = [["head":"头像","end":"","url":"\(model.headPath)/"],["head":"昵称","end":model.name,"url":""],["head":"性别","end":model.sex,"url":""],["head":"年龄","end":model.age,"url":""],["head":"手机号","end":model.phoneNumber,"url":""]]
        
        var lis:[MyInfoModel] = Array.init()
        
        for dic in ary.enumerated() {
            
            let model = MyInfoModel.init(dict: dic.element)
            
            if dic.offset == 0 {
                
                dataSorce.append([model])
            }else{
                lis.append(model)
            }
        }
        dataSorce.append(lis)
        self.delegate?.reloadData()
        
    }
    
}
