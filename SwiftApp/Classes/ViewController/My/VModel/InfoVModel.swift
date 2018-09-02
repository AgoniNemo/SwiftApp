//
//  InfoVModel.swift
//  SwiftApp
//
//  Created by Nemo on 2017/10/8.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import Foundation
import Alamofire

protocol InfoVModelDelegate:BaseVModelDelegate {
    
}

private protocol InfoVModelInterface:BaseVModelInterface {
    
    var delegate: InfoVModelDelegate? { get set }

    func numberOfSections() -> Int
    
    func uploadImage(data:Data) -> Void
}

class InfoVModel:InfoVModelInterface {
    
    weak var delegate: InfoVModelDelegate?
    
    private var dataSorce:[Any] = Array.init()
    
    func loadLate() {
        
    }
    
    func uploadImage(data:Data) {
        let model = UserModel.shareInstance
        
        let picName = model.name + "\(arc4random())\(arc4random())"
        
        self.delegate?.alertload!()
        
        UserInfoModifyManager.uploadRequest(multipartData: { (fromData) in
            fromData.append(data, withName: "file", fileName: "pic", mimeType:"image/jpeg")
            fromData.append(picName.data(using: .utf8)!, withName: "name")
            fromData.append(model.user.data(using: .utf8)!, withName: "user")
            fromData.append(model.token.data(using: .utf8)!, withName: "token")
            
        }) { [weak self](dict, err) in
            if err != nil{
                self?.delegate?.alertInfo(text: "上传失败！")
            }else{
                guard let dic:[String:Any] = dict!["data"] as? [String : Any] else{
                    debugPrint("---出错---")
                    self?.delegate?.alertInfo(text: "上传失败!")
                    return
                }
                
                guard let url:String = dic["url"] as? String else{
                    debugPrint("---出错---")
                    self?.delegate?.alertInfo(text: "上传失败!")
                    return
                }
                debugPrint(dict as Any)
                model.headPath = url
                let b = model.save()
                debugPrint("头像保存情况：\(b)")
                self?.loadingMore()
            }
            
        }
        
    }
    
    func numberOfSections() -> Int {
        
        return self.dataSorce.count
    }
    
    func indexPathModel(indexPath: IndexPath) -> MyInfoModel {
        
        let arry:[MyInfoModel] = self.dataSorce[indexPath.section] as! [MyInfoModel]

        return arry[indexPath.row]
        
    }
    
    
    func numberOfRowsInSection(section:Int) -> Int {
        
        let arry:[MyInfoModel] = self.dataSorce[section] as! [MyInfoModel]
        
        return arry.count
    }
    
    func loadingMore() {
        dataSorce.removeAll()
        let model = UserModel.shareInstance
        
        let ary = [["head":"头像","end":"","url":"\(model.headPath) "],["head":"昵称","end":model.name,"url":""],["head":"性别","end":model.sex,"url":""],["head":"年龄","end":model.age,"url":""],["head":"手机号","end":model.phoneNumber,"url":""],["head":"修改密码","end":"","url":""]]
        
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
