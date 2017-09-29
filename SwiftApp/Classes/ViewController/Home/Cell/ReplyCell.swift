//
//  ReplyCell.swift
//  SwiftApp
//
//  Created by Nemo on 2017/9/29.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import UIKit

class ReplyCell: UITableViewCell {

    
    
    func setModel(model:ReplyModel) -> Void {
        
        self.nameLable.text = model.username
        self.contentLable.text = model.content
        self.timeLable.text = model.duration
    }
    
    class func cell(WithTableView tabView:UITableView) -> ReplyCell{
        
        let Id = "\(ReplyCell.description())"
        var cell = tabView.dequeueReusableCell(withIdentifier: Id) as? ReplyCell
        
        if cell == nil {
            
            cell = ReplyCell.init(style: .default, reuseIdentifier: Id)
            cell?.selectionStyle = .none
        }
        return cell!
        
    }
    
    
    // MARK:回复时间
    lazy var timeLable:UILabel = {
        
        let w:CGFloat = 200
        
        let t:UILabel = UILabel.init(frame: XCGRect(SCREEN_WIDTH - w - 10, 2, w, 20))
        t.font = UIFont.systemFont(ofSize: 12)
        t.textAlignment = .right
        self.contentView.addSubview(t)
        
        return t
    }()
    
    // MARK:内容
    lazy var contentLable:UILabel = {
        
        let x:CGFloat = self.iconView.frame.maxX + 10
        let y:CGFloat = self.iconView.frame.minX
        let h:CGFloat = self.iconView.frame.height
        
        let c:UILabel = UILabel.init(frame: XCGRect(x, y, self.contentView.frame.width - x, h))
        c.font = UIFont.systemFont(ofSize: 12)
        self.contentView.addSubview(c)
        
        return c
    }()
    
    // MARK:名字
    lazy var nameLable:UILabel = {
        
        let x:CGFloat = 10.0
        
        let n:UILabel = UILabel.init(frame: XCGRect(x, 2, 50, 20))
        n.font = UIFont.systemFont(ofSize: 14)
        n.textAlignment = .center
        self.contentView.addSubview(n)
        
        return n
    }()
    
    // MARK:用户头像
    lazy var iconView:UIImageView = {
        
        let icon = UIImageView.init(frame: XCGRect(10, self.nameLable.frame.maxY+5, 50, 50))
        icon.backgroundColor = HOMECOLOR;
        icon.layer.masksToBounds = true
        icon.layer.cornerRadius = 5
        
        self.contentView.addSubview(icon)
        
        return icon
    }()

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
