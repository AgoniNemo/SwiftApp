//
//  HistoryCell.swift
//  SwiftApp
//
//  Created by Nemo on 2017/10/7.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import UIKit

class HistoryCell: UICollectionViewCell {
    
    
    typealias Completion = () -> ()
    var closure:Completion?;
    
    class func cell(WithCollectionView collectionView:UICollectionView ,index:IndexPath) -> HistoryCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(self)", for: index)
        
        return cell as! HistoryCell
        
    }
    
    
    func setModel(model:HisAColModel) -> Void {
        self.iconView.kf.setImage(with: URL(string: (model.video?.icon)!))
        self.titleLable.text = model.video?.title
        self.contentView.addSubview(self.delBtn)
        self.timeLable.text = Date.formattedDateDescription(stringTime: model.time)
    }
    
    @objc private func deleteAction() -> Void {
        
        if self.closure != nil {
            self.closure!()
        }
        
    }
    
    lazy var timeLable: UILabel = {
        let t:UILabel = UILabel.init(frame: XCGRect(5, self.contentView.height! - 20, self.iconView.width!-20, 20))
        t.font = UIFont.systemFont(ofSize: 13)
        t.numberOfLines = 0
        t.isUserInteractionEnabled = true
        t.textColor = UIColor.lightGray
        self.contentView.addSubview(t)
        return t
    }()
    
    private lazy var delBtn: UIButton = {
        let d:UIButton = UIButton.init(type: .system)
        d.frame = XCGRect(self.contentView.width! - 45, self.contentView.height! - 20, 40, 20)
        d.setTitle("删除", for: .normal)
        d.setTitleColor(HOMECOLOR, for: .normal)
        d.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        d.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
        return d
    }()
    
    private lazy var titleLable: UILabel = {
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
