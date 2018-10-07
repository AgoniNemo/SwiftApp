//
//  CategoriesVModel.swift
//  SwiftApp
//
//  Created by Nemo on 2017/10/1.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import Foundation


protocol CategoriesVModelDelegate:BaseVModelDelegate {
    
}

protocol CategoriesVModelInterface:BaseVModelInterface {
    var delegate: CategoriesVModelDelegate? { get set }
}

class CategoriesVModel:CategoriesVModelInterface {
    
    weak var delegate: CategoriesVModelDelegate?
    
    private var dataSource:[CategoriesModel] = Array.init();
    
    private let lists:[[String:String]] = [["icon": "51", "title": "3P群交", "key": "/3pqj/"], ["icon": "65", "title": "HD高清", "key": "/adgq/"], ["icon": "53", "title": "凹凸门事件", "key": "/atmsj/"], ["icon": "62", "title": "潮吹", "key": "/cc/"], ["icon": "54", "title": "长视频", "key": "/csp/"], ["icon": "64", "title": "大屌", "key": "/dd/"], ["icon": "47", "title": "动漫", "key": "/dm/"], ["icon": "55", "title": "短视频", "key": "/dsp/"], ["icon": "43", "title": "国产", "key": "/gc/"], ["icon": "57", "title": "户外野外公共场所", "key": "/hwyw/"], ["icon": "45", "title": "剧情三级", "key": "/jqsj/"], ["icon": "63", "title": "口爆颜射", "key": "/kbys/"], ["icon": "46", "title": "口交足交", "key": "/kjzj/"], ["icon": "58", "title": "学生妹校园", "key": "/msmxy/"], ["icon": "52", "title": "男同女同", "key": "/ntnt/"], ["icon": "44", "title": "欧美", "key": "/om/"], ["icon": "60", "title": "器具及自慰", "key": "/qjjzw/"], ["icon": "42", "title": "日韩", "key": "/rh/"], ["icon": "48", "title": "人妻乱伦偷情", "key": "/rqlltq/"], ["icon": "67", "title": "人妻熟女", "key": "/rqsn/"], ["icon": "50", "title": "SM调教", "key": "/smtj/"], ["icon": "61", "title": "少女美女", "key": "/sn/"], ["icon": "68", "title": "性爱", "key": "/xa/"], ["icon": "56", "title": "直播", "key": "/zb/"], ["icon": "41", "title": "制服丝袜", "key": "/zfsw/"], ["icon": "66", "title": "重口味", "key": "/zkw/"], ["icon": "49", "title": "自拍偷拍", "key": "/zptp/"], ["icon": "59", "title": "中文字幕", "key": "/zwzm/"]]


    
    func loadingMore() {
        self.request()
    }
    
    func loadLate() {
        self.request()
    }
    
    private func request() -> Void{
        
        for obj in self.lists.enumerated() {
            let model = CategoriesModel.init(dict: obj.element)
            self.dataSource.append(model)
        }

    }
    
    func indexPathModel(indexPath: IndexPath) -> CategoriesModel {
        
        return self.dataSource[indexPath.row]
        
    }
    
    
    func numberOfRowsInSection(section:Int) -> Int {
        return self.dataSource.count
    }

}
