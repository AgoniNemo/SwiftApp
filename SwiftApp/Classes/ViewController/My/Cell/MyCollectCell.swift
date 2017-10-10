//
//  MyCollectCell.swift
//  SwiftApp
//
//  Created by Nemo on 2017/10/8.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import UIKit

class MyCollectCell: UICollectionViewCell {
    
        
    typealias Completion = () -> ()
    var closure:Completion?;
    
    class func cell(WithCollectionView collectionView:UICollectionView ,index:IndexPath) -> MyCollectCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(self)", for: index)
        
        return cell as! MyCollectCell
        
    }
    
    
    func setModel(model:HisAColModel) -> Void {
        
        if DEVELOP_TEST == false {
            self.iconView.kf.setImage(with: URL(string: (model.video?.icon)!))
            self.titleLabel.text = model.video?.title
            self.contentView.addSubview(self.delBtn)
            self.timeLable.text = "\(model.video?.duration ?? String())\t"
            self.viewsLable.text = " 观看次数:\(model.video?.views ?? String())"
        }else{
            self.iconView.image = #imageLiteral(resourceName: "Avatar")
            self.titleLabel.text = "model.title"
            self.timeLable.text = "model.duration"
            self.timeLable.text = "\(model.video?.duration ?? String())\t"
            self.viewsLable.text = " 观看次数:\(model.video?.views ?? String())"
        }
    }
    
    @objc private func deleteAction() -> Void {
        
        if self.closure != nil {
            self.closure!()
        }
        
    }
    
    
    lazy var viewsLable:UILabel = {
        
        let y = self.iconView.height!-25
        let w = self.iconView.width! -  self.timeLable.width! + 20
        let v:UILabel = UILabel.init(frame: XCGRect(0, y, w, 25))
        v.font = UIFont.boldSystemFont(ofSize: 13)
        v.textColor = UIColor.white
        v.backgroundColor = RGBA(r: 0, g: 0, b: 0, a: 0.6)
        self.iconView.addSubview(v)
        
        return v
    }()
    
    lazy var timeLable: UILabel = {
        
        let t:UILabel = UILabel.init(frame: XCGRect(self.iconView.width! - 100, self.iconView.height! - 25, 100, 25))
        t.font = UIFont.systemFont(ofSize: 13)
        t.textAlignment = .right
        t.isUserInteractionEnabled = true
        t.textColor = UIColor.white
        t.backgroundColor = RGBA(r: 0, g: 0, b: 0, a: 0.6)
        self.iconView.addSubview(t)
        return t
    }()
    
    private lazy var delBtn: UIButton = {
        let d:UIButton = UIButton.init(type: .system)
        d.frame = XCGRect(self.contentView.width! - 65, self.contentView.height! - 20, 60, 20)
        d.setTitle("取消收藏", for: .normal)
        d.setTitleColor(HOMECOLOR, for: .normal)
        d.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        d.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
        return d
    }()
    
    private lazy var titleLabel: UILabel = {
        let t:UILabel = UILabel.init(frame: XCGRect(5, self.iconView.maxY!+1, self.iconView.width!, 40))
        t.font = UIFont.systemFont(ofSize: 13)
        t.numberOfLines = 0
        t.isUserInteractionEnabled = true
        self.contentView.addSubview(t)
        return t
    }()
    
    private lazy var iconView: UIImageView = {
        let w = self.contentView.width!-10
        let h = 180/240*w
        let i:UIImageView = UIImageView.init(frame: XCGRect(5, 5, w, h))
        i.backgroundColor = HOMECOLOR
        i.isUserInteractionEnabled = true
        
        let maskPath = UIBezierPath.init(roundedRect: i.bounds, byRoundingCorners:[.topLeft , .topRight,.bottomLeft,.bottomRight], cornerRadii: CGSize.init(width: 6, height: 6))
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = i.bounds
        maskLayer.path = maskPath.cgPath
        i.layer.mask = maskLayer
        
        self.contentView.addSubview(i)
        return i
    }()
    
}
