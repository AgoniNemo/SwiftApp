//
//  CategoriesCell.swift
//  SwiftApp
//
//  Created by Nemo on 2017/10/1.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import UIKit

class CategoriesCell: UICollectionViewCell {
    
    
    class func cell(WithCollectionView collectionView:UICollectionView ,index:IndexPath) -> CategoriesCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(self)", for: index)
        
        return cell as! CategoriesCell
        
    }
    
    func setModel(model:CategoriesModel) -> Void {
        if DEVELOP_TEST == false {
            self.iconView.image = UIImage.init(named: model.icon)
            self.titleLable.text = model.title
        }
    }
    
    lazy var titleLable: UILabel = {
        let t = UILabel.init(frame: XCGRect(0, self.iconView.maxY!-25, self.width!, 25))
        t.backgroundColor = RGBA(r: 0, g: 0, b: 0, a: 0.6)
        t.textColor = UIColor.white
        t.font = UIFont.systemFont(ofSize: 15)
        t.textAlignment = .center
        self.contentView.addSubview(t)
        return t
    }()
    
    lazy var iconView: UIImageView = {
        let i:UIImageView = UIImageView.init(frame: XCGRect(0, 0, self.width!, self.height!))
        i.isUserInteractionEnabled = true
        i.layer.masksToBounds = true
        i.layer.cornerRadius = 5
        
        i.layer.borderWidth = 1
        i.layer.borderColor = UIColor.clear.cgColor
        
        i.layer.shadowColor = UIColor.black.cgColor
        i.layer.shadowOpacity = 2
        i.layer.shadowOffset = CGSize.init(width: 1, height: 1)
        
        self.contentView.addSubview(i)
        return i
    }()
    
    
}
