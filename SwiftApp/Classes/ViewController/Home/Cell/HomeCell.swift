//
//  HomeCell.swift
//  SwiftApp
//
//  Created by Mjwon on 2017/9/20.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import UIKit
import Kingfisher

class HomeCell: UITableViewCell {

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func setModel(model:VideoModel) -> Void {
        

        self.bgView.backgroundColor = RGBA(r: 250, g: 250, b: 250, a: 0.9)
        
        if DEVELOP_TEST == false {
            self.iconView.kf.setImage(with: URL(string: model.icon))
            self.titleLabel.text = model.title
            self.timeLable.text = "\(model.duration)\t"
            self.ratingLable.text = "评分:\(model.rating)"
            self.viewsLable.text = "  观看次数:\(model.views)"
        }
    }
    
    class func cell(WithTableView tabView:UITableView) -> HomeCell{
    
        let Id = "\(HomeCell.description())"
        var cell = tabView.dequeueReusableCell(withIdentifier: Id) as? HomeCell
        
        if cell == nil {
            
            cell = HomeCell.init(style: .default, reuseIdentifier: Id)
            cell?.selectionStyle = .none
        }
        return cell!
        
    }
    
    /// MARK:观看次数
    lazy var viewsLable:UILabel = {
        
        let y = self.iconView.maxY!-30
        let w = self.iconView.width! -  self.timeLable.width!
        let v:UILabel = UILabel.init(frame: XCGRect(0, y, w, 30))
        v.font = UIFont.boldSystemFont(ofSize: 15)
        v.textColor = UIColor.white
        v.backgroundColor = RGBA(r: 0, g: 0, b: 0, a: 0.6)
        self.bgView.addSubview(v)
        
        if DEVELOP_TEST == true {
            v.text = "viewsLable"
            v.backgroundColor = UIColor.brown
        }
        
        return v
    }()
    
    /// MARK:评分
    lazy var ratingLable:UILabel = {
    
        let y = self.titleLabel.maxY!+5
        let r:UILabel = UILabel.init(frame: XCGRect(5, y, 80, 20))
        r.font = UIFont.boldSystemFont(ofSize: 15)
        
        self.bgView.addSubview(r)
        
        if DEVELOP_TEST == true {
            r.text = "ratingLable"
            r.backgroundColor = UIColor.orange
        }
        
        return r
    }()
    
    /// MARK:时间
    lazy var timeLable:UILabel = {
        let y:CGFloat = self.iconView.maxY!-30
        let x = self.iconView.width!-150
        let t:UILabel = UILabel.init(frame: XCGRect(x,y, 150, 30))
        t.font = UIFont.boldSystemFont(ofSize: 15)
        t.textAlignment = .right
        t.textColor = UIColor.white
        t.backgroundColor = RGBA(r: 0, g: 0, b: 0, a: 0.6)
        self.bgView.addSubview(t)
        if DEVELOP_TEST == true {
            t.text = "timeLable"
            t.backgroundColor = UIColor.red
        }
        return t
    }()
    
    /// MARK:标题
    lazy var titleLabel:UILabel = {
        let y:CGFloat = self.iconView.maxY!;
        let w:CGFloat = self.iconView.width!-10
        let l:UILabel = UILabel.init(frame: XCGRect(5, y, w, 40))
        l.numberOfLines = 0
        l.font = UIFont.systemFont(ofSize: 16)
        self.bgView.addSubview(l)
        
        if DEVELOP_TEST == true {
            l.backgroundColor = UIColor.blue
            l.text = "title"
        }
        return l
    }()
    
    lazy var iconView:UIImageView = {
        let w:CGFloat = self.bgView.width!
        let h:CGFloat = 72.0/96.0*w
        let icon = UIImageView.init(frame: XCGRect(0, 0, w, 180))
        icon.backgroundColor = HOMECOLOR;
        icon.contentMode = .scaleAspectFill
        
        let maskPath = UIBezierPath.init(roundedRect: icon.bounds, byRoundingCorners:[ UIRectCorner.topLeft , UIRectCorner.topRight], cornerRadii: CGSize.init(width: 5, height: 5))
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = icon.bounds
        maskLayer.path = maskPath.cgPath
        icon.layer.mask = maskLayer
        
        self.bgView.addSubview(icon)
        
        return icon
    }()
    
    lazy var bgView: UIView = {
        let x:CGFloat = 15.0
        let w:CGFloat = SCREEN_WIDTH-2*x
        let h:CGFloat = 240.0 / 180.0 * w
        let v  = UIView.init(frame: XCGRect(x, 10, w, 250))
        
//        v.clipsToBounds = true
        v.layer.cornerRadius = 5
        v.layer.borderWidth = 0.3
        v.layer.borderColor = UIColor.clear.cgColor
        
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 0.5
        v.layer.shadowOffset = CGSize.init(width: 1, height: 1)
        
        self.contentView.addSubview(v)
        return v
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
