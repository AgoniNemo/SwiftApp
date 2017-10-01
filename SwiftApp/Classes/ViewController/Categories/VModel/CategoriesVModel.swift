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
    
}

class CategoriesVModel:CategoriesVModelInterface {
    
    weak var delegate: BaseVModelDelegate?
    
    private var dataSource:[CategoriesModel] = Array.init();
    
    private let lists:[[String:String]] = [["icon": "27.jpg", "title": "成人动漫"], ["icon": "31.jpg", "title": "长视频"], ["icon": "22.jpg", "title": "潮喷"], ["icon": "16.jpg", "title": "大屌"], ["icon": "15.jpg", "title": "肛交"], ["icon": "12.jpg", "title": "高清HD"], ["icon": "36.jpg", "title": "男同性恋"], ["icon": "6.jpg", "title": "国产自拍"], ["icon": "9.jpg", "title": "巨乳波霸"], ["icon": "8.jpg", "title": "口爆颜射"], ["icon": "26.jpg", "title": "性感美女"], ["icon": "24.jpg", "title": "嫩妹"], ["icon": "33.jpg", "title": "女同性恋"], ["icon": "3.jpg", "title": "欧美性爱"], ["icon": "34.jpg", "title": "日韩情色"], ["icon": "30.jpg", "title": "公众户外"], ["icon": "17.jpg", "title": "自慰器具"], ["icon": "7.jpg", "title": "集体群交"], ["icon": "28.jpg", "title": "强奸"], ["icon": "10.jpg", "title": "熟女人妻"], ["icon": "39.jpg", "title": "青娱乐美女热舞"], ["icon": "5.jpg", "title": "日本无码"], ["icon": "25.jpg", "title": "性爱"], ["icon": "29.jpg", "title": "丝袜美腿"], ["icon": "11.jpg", "title": "SM调教"], ["icon": "18.jpg", "title": "素人"], ["icon": "35.jpg", "title": "偷情乱伦"], ["icon": "40.jpg", "title": "VIP会员专区"], ["icon": "32.jpg", "title": "短视频"], ["icon": "23.jpg", "title": "校园激情"], ["icon": "2.jpg", "title": "亚洲性爱"], ["icon": "4.jpg", "title": "日本有码"], ["icon": "21.jpg", "title": "制服诱惑"], ["icon": "37.jpg", "title": "重口味"], ["icon": "19.jpg", "title": "中文字幕"], ["icon": "13.jpg", "title": "网络主播"], ["icon": "20.jpg", "title": "足交"]]
    
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
    
    func rowModel(row: Int) -> CategoriesModel {
        
        return self.dataSource[row]
    }
    
    func numberOfRowsInSection() -> Int {
        debugPrint(self.dataSource.count)
        return self.dataSource.count
    }

    
    
    
}
