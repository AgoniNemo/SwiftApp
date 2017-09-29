//
//  HomeVModel.swift
//  SwiftApp
//
//  Created by Mjwon on 2017/9/20.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import Foundation


@objc protocol HomeVModelDelegate {
    
    func alertInfo(text:String)
    func reloadData()
    func alertload()
}

protocol HomeVModelInterface {
    weak var delegate: HomeVModelDelegate? { get set }
    func numberOfRowsInSection() -> Int
    func loadingMore()
    func rowModel(row:Int) -> VideoModel
    func loadLate()
}


class HomeVModel:HomeVModelInterface {
    
    weak var delegate: HomeVModelDelegate?
    
    private var page:Int = 0
    
    var dataSource:[VideoModel] = Array.init();
    
    
    func loadingMore() {
        page += 1
        self.request()
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
            "page":"\(page)"
        ]
        debugPrint("page:\(page)")
        VideoNetManager.loadVideoRequest(params: params) { [weak self](dict, err) in
            
            guard let d:[String:Any] = dict else{
                self?.delegate?.alertInfo(text: "数据加载失败!")
                return
            }
//            debugPrint(dict as Any)
            
            if err == nil{
                guard let datas:[[String:Any]] = d["data"] as? [[String : Any]] else{
                    let mesg = d["message"] as! String
                    self?.delegate?.alertInfo(text: mesg)
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
    
    func rowModel(row: Int) -> VideoModel {
        return self.dataSource[row]
    }
    
    func numberOfRowsInSection() -> Int {
        return self.dataSource.count
    }
    
}
