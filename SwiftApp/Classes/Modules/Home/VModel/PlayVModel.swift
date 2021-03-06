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
    
    var delegate: PlayVModelDelegate? { get set }
    
    func commit(text:String) -> Void
    func sava() -> Bool
    func collect(b:Bool) -> Void
    
}

class PlayVModel: PlayVModelInterface {
    
    var model: VideoModel?
    
    weak var delegate: PlayVModelDelegate?
        
    private var dataSorce:[ReplyModel] = []
    
    func loadLate() {
        
    }
    
    func collect(b:Bool) -> Void {
        let token = UserModel.shareInstance.token
        let user = UserModel.shareInstance.user
        let id:String = (self.model?.id)!
        let status = b ? "1" : "0"
        
        let params = [
            "user":user,
            "token":token,
            "id":id,
            "collection":status
        ]
        self.delegate?.alertload!()
        
        CollectNetManager.collectRequest(params: params) { [weak self](dict, err) in
            
            guard let dic:[String:Any] = dict else{
                self?.delegate?.alertInfo(text: "数据加载失败!")
                return
            }
            
            XLogLine(dic as Any)
            
            guard let d:[String:Any] = dic["data"] as? [String : Any] else{
                self?.delegate?.alertInfo(text: "数据加载失败!")
                return
            }
            
            let s:Bool = (d["status"] as? Bool)!
            
            if err == nil,s == true{
                
                let text = b ? "收藏成功!" : "取消收藏成功!"
                self?.delegate?.alertInfo(text: text)
                self?.model?.collect(b: b)
            }else{
                self?.delegate?.alertInfo(text: "操作失败!")
            }
            
        }
        
    }
    
    func sava() -> Bool {
        return (model?.save())!
    }
    
    func indexPathModel(indexPath: IndexPath) -> ReplyModel {
        
        return self.dataSorce[indexPath.row]
        
    }
    
    func numberOfRowsInSection(section:Int) -> Int {
        return self.dataSorce.count
    }
    
    func commit(text: String) {
        
        let token = UserModel.shareInstance.token
        let user = UserModel.shareInstance.user
        let headPath = UserModel.shareInstance.headPath
        let time = Date.intTimestamp()
        let id:String = (self.model?.id)!
        
        let params = [
            "id":id,
            "user":user,
            "token":token,
            "content":"\(text)",
            "time":"\(time)"
        ]
        
        CommentNetManager.commitRequest(params: params) {[weak self] (dict, err) in
            guard let d:[String:Any] = dict else{
                self?.delegate?.alertInfo(text: "数据加载失败!")
                return
            }
            
            XLogLine(d as Any)
            
            if err == nil{
                let dict = [
                    "time":"\(time)",
                    "name":"\(UserModel.shareInstance.name)",
                    "content":"\(text)",
                    "headPath":headPath
                ]
                let model = ReplyModel.init(dict: dict)
                self?.dataSorce.append(model)
                self?.delegate?.reloadData()
            
            }else{
                self?.delegate?.alertInfo(text: "评论提交失败!")
            }
            
        }
        
        
    }
    
    func loadingMore() {
        
        let token = UserModel.shareInstance.token
        let user = UserModel.shareInstance.user
        let id:String = (self.model?.id)!
        
        let params = [
            "id":id,
            "user":user,
            "token":token
        ]
        
        CommentNetManager.commitListRequest(params: params) { [weak self](dict, err) in
            
            
            XLogLine(dict as Any)
            
            guard let d:[String:Any] = dict else{
                self?.delegate?.alertInfo(text: "数据加载失败!")
                return
            }
            
            if err == nil{
                
                guard let arry:[[String:String]] = d["data"] as? [[String : String]]  else{
                    self?.delegate?.alertInfo(text: "数据加载失败!")
                    return
                }
                for dic in arry.enumerated(){
                
                    let model = ReplyModel.init(dict: dic.element)
                    self?.dataSorce.append(model)
                }
                self?.delegate?.reloadData()
                
            }else{
                self?.delegate?.alertInfo(text: "数据加载失败!")
            }

        }
        
    }

}
