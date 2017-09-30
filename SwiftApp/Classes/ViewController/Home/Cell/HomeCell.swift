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

    let isTest = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func setModel(model:VideoModel) -> Void {
        
        self.contentView.addSubview(self.iconView)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.timeLable)
        self.contentView.addSubview(self.ratingLable)
        self.contentView.addSubview(self.viewsLable)
        
        if isTest == false {
            self.iconView.kf.setImage(with: URL(string: model.icon))
            self.titleLabel.text = model.title
            self.timeLable.text = "时间:\(model.duration)"
            self.ratingLable.text = "评分:\(model.rating)"
            self.viewsLable.text = "观看人数:\(model.views)"
        }
    }
    
    class func cell(WithTableView tabView:UITableView) -> HomeCell{
    
        let Id = "\(HomeCell.description())"
        var cell = tabView.dequeueReusableCell(withIdentifier: Id) as? HomeCell
        
        if cell == nil {
            
            cell = HomeCell.init(style: .default, reuseIdentifier: Id)
        }
        return cell!
        
    }
    
    /// MARK:观看人数
    lazy var viewsLable:UILabel = {
        
        let x = self.ratingLable.maxX!
        let v:UILabel = UILabel.init(frame: XCGRect(x, self.timeLable.maxY!, SCREEN_WIDTH-x-10, 20))
        v.font = UIFont.systemFont(ofSize: 14)
        
        if self.isTest == true {
            v.text = "viewsLable"
            v.backgroundColor = UIColor.brown
        }
        
        return v
    }()
    
    /// MARK:评分
    lazy var ratingLable:UILabel = {
    
        let x = self.titleLabel.minX!
        let r:UILabel = UILabel.init(frame: XCGRect(x, self.timeLable.maxY!, 80, 20))
        r.font = UIFont.systemFont(ofSize: 14)
        
        if self.isTest == true {
            r.text = "ratingLable"
            r.backgroundColor = UIColor.orange
        }
        
        return r
    }()
    
    /// MARK:时间
    lazy var timeLable:UILabel = {
        let x = self.titleLabel.minX!
        let t:UILabel = UILabel.init(frame: XCGRect(x, self.titleLabel.maxY!, SCREEN_WIDTH-x-10, 20))
        t.font = UIFont.systemFont(ofSize: 14)
        
        if self.isTest == true {
            t.text = "timeLable"
            t.backgroundColor = UIColor.red
        }
        return t
    }()
    
    /// MARK:标题
    lazy var titleLabel:UILabel = {
        let x:CGFloat = self.iconView.maxX!+5;
        let l:UILabel = UILabel.init(frame: XCGRect(x, 7, SCREEN_WIDTH-x-10, 40))
        l.numberOfLines = 0
        l.font = UIFont.boldSystemFont(ofSize: 15)
        
        if self.isTest == true {
            l.backgroundColor = UIColor.blue
            l.text = "title"
        }
        return l
    }()
    
    lazy var iconView:UIImageView = {
    
        let icon = UIImageView.init(frame: XCGRect(10, 10, 96, 72))
        icon.backgroundColor = HOMECOLOR;
        
        
        return icon
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
