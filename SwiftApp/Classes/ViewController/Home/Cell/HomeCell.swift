//
//  HomeCell.swift
//  SwiftApp
//
//  Created by Mjwon on 2017/9/20.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func setModel(model:VideoModel) -> Void {
        
        self.contentView.addSubview(self.iconView)
        self.contentView.addSubview(self.titleLabel)
    }
    
    class func cell(WithTableView tabView:UITableView) -> HomeCell{
    
        let Id = "\(HomeCell.description())"
        var cell = tabView.dequeueReusableCell(withIdentifier: Id) as? HomeCell
        
        if cell == nil {
            
            cell = HomeCell.init(style: .default, reuseIdentifier: Id)
        }
        return cell!
        
    }
    
    let titleLabel:UILabel = {
        
        let l = UILabel.init(frame: XCGRect(70, 10, SCREEN_WIDTH-70, 30))
        l.text = "title"
        
        return l
    }()
    
    
    lazy var iconView:UIImageView = {
    
        let icon = UIImageView.init(frame: XCGRect(10, 10, 50, 50))
        icon.backgroundColor = HOMECOLOR;
        
        
        return icon
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
