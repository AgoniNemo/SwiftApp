//
//  CatgrListVModel.swift
//  SwiftApp
//
//  Created by Nemo on 2017/10/7.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import Foundation

protocol CatgrListVModelDelegate:BaseVModelDelegate {
    
}

protocol CatgrListVModelInterface:BaseVModelInterface {
    var delegate: CatgrListVModelDelegate? { get set }
    
}

class CatgrListVModel:CatgrListVModelInterface {
    
    weak var delegate: CatgrListVModelDelegate?
    
    private var dataSource:[VideoModel] = Array.init();
    private var page:Int = 0
    
    var key:String = ""
    
    
    func loadingMore() {
        self.request()
        page += 1
    }
    
    func loadLate() {
        page = 0
        self.request()
    }
    
    private func request() -> Void{
        
        let token = UserModel.shareInstance.token
        let user = UserModel.shareInstance.user
        
        let params = [
            "user":user,
            "token":token,
            "count":"20",
            "page":"\(page)",
            "categories":"\(key)"
        ]
        
        CategoriesNetManager.sortQueryRequest(params: params) { [weak self](dict, err) in
            
            guard let d:[String:Any] = dict else{
                self?.delegate?.alertInfo(text: "数据加载失败!")
                return
            }
            
//            XLogLine(dict as Any)
            
            if err == nil{
                guard let datas:[[String:Any]] = d["data"] as? [[String : Any]] else{
                    let mesg = d["message"] as? String
                    if mesg == nil{
                        self?.delegate?.alertInfo(text: "数据加载出错！")
                        return
                    }
                    self?.delegate?.alertInfo(text: mesg!)
                    return
                }
                
                if datas.count == 0{
                    self?.delegate?.noMoreData!()
                    return
                }
                
                if datas.count > 0,self?.page == 0{
                    self?.dataSource.removeAll()
                }
                for (_,dic) in datas.enumerated(){
                    
                    let model = VideoModel.init(dict: dic)
                    self?.dataSource.append(model)
                }
            }else{
                self?.delegate?.alertInfo(text: "数据加载失败!")
            }
            
            self?.delegate?.reloadData()
            
        }
        
    }
    
    
    func indexPathModel(indexPath: IndexPath) -> VideoModel {
        
        return self.dataSource[indexPath.row]
        
    }
    
    func numberOfRowsInSection(section:Int) -> Int {

        return self.dataSource.count
    }

    
}
