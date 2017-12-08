//
//  HomeVModel.swift
//  SwiftApp
//
//  Created by Mjwon on 2017/9/20.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import Foundation


protocol HomeVModelDelegate:BaseVModelDelegate {
    
}

protocol HomeVModelInterface:BaseVModelInterface {

    weak var delegate: HomeVModelDelegate? { get set }

}

class HomeVModel:HomeVModelInterface {
    
    weak var delegate: HomeVModelDelegate?

    private var page:Int = 0
    
    var dataSource:[VideoModel] = Array.init();
    
    
    func loadingMore() {
        self.request()
        page += 1
    }
    
    func loadLate() {
        page = 0
        self.request()
    }
    
    // -MARK:同步收藏数据
    func updateCollect() -> Void {
        
        let token = UserModel.shareInstance.token
        let user = UserModel.shareInstance.user
        let params = [
            "user":user,
            "token":token
        ]
        
        CollectNetManager.collectListRequest(params: params) { (dict, err) in
            
            guard let d:[String:Any] = dict else{
                debugPrint("数据加载失败!")
                return
            }
            if err == nil{
                debugPrint(d)
                guard let datas:[[String:Any]] = d["data"] as? [[String : Any]] else{
                    let mesg = d["message"] as? String
                    if mesg == nil{
                        debugPrint(d)
                        return
                    }
                    return
                }
                
                let models = HisAColModel.allCollect()
                
                if models.count > 0 {
                    let locDtStr = (models.last)!["collectTime"] as! String
                    let netDtStr = datas.last!["video_updated_at"] as! String
                    if locDtStr == netDtStr {
                        return
                    }
                }
                
                for dict in datas{
                   var d = dict
                   d["watchTime"] = Date.stringTimestamp()
                   d["collectTime"] = d["video_updated_at"]
                   d.removeValue(forKey: "video_updated_at")
                   d["user"] = user
                   let model = HisAColModel.init(dict: d)
                    
                   model.collect()
                    
                }
                // 删除不是观看历史与收藏的数据
                let b = HisAColModel.delete()
                debugPrint("删除状态:\(b)")
            }else{
                debugPrint("错误:\(String(describing: err))")
            }
            
        }
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
//        debugPrint("page:\(page)")
        VideoNetManager.loadVideoRequest(params: params) { [weak self](dict, err) in
            
            guard let d:[String:Any] = dict else{
                self?.delegate?.alertInfo(text: "数据加载失败!")
                return
            }
//            debugPrint(dict as Any)
            
            if err == nil{
                guard let datas:[[String:Any]] = d["data"] as? [[String : Any]] else{
                    let mesg = d["message"] as? String
                    if mesg == nil{
                        debugPrint(d)
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
