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
    
    func commit(text:String) -> Void
    
}

class PlayVModel: PlayVModelInterface {
    
    weak var delegate: PlayVModelDelegate?
    
    var id:String = ""
    
    
    private var dataSorce:[ReplyModel] = []
    
    func loadLate() {
        
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
            
            debugPrint(d as Any)
            
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
        
        let params = [
            "id":id,
            "user":user,
            "token":token
        ]
        
        CommentNetManager.commitListRequest(params: params) { [weak self](dict, err) in
            
            
            debugPrint(dict as Any)
            
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
