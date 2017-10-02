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
    weak var delegate: CategoriesVModelDelegate? { get set }
}

class CategoriesVModel:CategoriesVModelInterface {
    
    weak var delegate: CategoriesVModelDelegate?
    
    private var dataSource:[CategoriesModel] = Array.init();
    
    private let lists:[[String:String]] = [["icon":"27.jpg","title":"成人动漫","key":"/cartoon/"], ["icon":"31.jpg","title":"长视频","key":"/changshipin/"], ["icon":"22.jpg","title":"潮喷","key":"/chaopen/"], ["icon":"16.jpg","title":"大屌","key":"/dadiao/"], ["icon":"15.jpg","title":"肛交","key":"/gangjiao/"], ["icon":"12.jpg","title":"高清HD","key":"/gaoqing/"], ["icon":"36.jpg","title":"男同性恋","key":"/gay/"], ["icon":"6.jpg","title":"国产自拍","key":"/guochan/"], ["icon":"9.jpg","title":"巨乳波霸","key":"/juru/"], ["icon":"8.jpg","title":"口爆颜射","key":"/koubaoyanshe/"], ["icon":"26.jpg","title":"性感美女","key":"/meinv/"], ["icon":"24.jpg","title":"嫩妹","key":"/nenmei/"], ["icon":"33.jpg","title":"女同性恋","key":"/nvtong/"], ["icon":"3.jpg","title":"欧美性爱","key":"/oumei/"], ["icon":"34.jpg","title":"日韩情色","key":"/party/"], ["icon":"30.jpg","title":"公众户外","key":"/public/"], ["icon":"17.jpg","title":"自慰器具","key":"/qijuziwei/"], ["icon":"7.jpg","title":"集体群交","key":"/qunjiao/"], ["icon":"28.jpg","title":"强奸","key":"/rapping/"], ["icon":"10.jpg","title":"熟女人妻","key":"/renqishunv/"], ["icon":"39.jpg","title":"青娱乐美女热舞","key":"/rewu/"], ["icon":"5.jpg","title":"日本无码","key":"/ribenwuma/"], ["icon":"25.jpg","title":"性爱","key":"/sex/"], ["icon":"29.jpg","title":"丝袜美腿","key":"/siwa/"], ["icon":"11.jpg","title":"SM调教","key":"/smxingnue/"], ["icon":"18.jpg","title":"素人","key":"/suren/"], ["icon":"35.jpg","title":"偷情乱伦","key":"/touqingyuluanlun/"], ["icon":"40.jpg","title":"VIP会员专区","key":"/vip/"], ["icon":"32.jpg","title":"短视频","key":"/xiaobian/"], ["icon":"23.jpg","title":"校园激情","key":"/xiaoyuan/"], ["icon":"2.jpg","title":"亚洲性爱","key":"/yazhou/"], ["icon":"4.jpg","title":"日本有码","key":"/youma/"], ["icon":"21.jpg","title":"制服诱惑","key":"/zhifu/"], ["icon":"37.jpg","title":"重口味","key":"/zhongkouwei/"], ["icon":"19.jpg","title":"中文字幕","key":"/zhongwenzimu/"], ["icon":"13.jpg","title":"网络主播","key":"/zhubo/"], ["icon":"20.jpg","title":"足交","key":"/zujiao/"]]

    
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
