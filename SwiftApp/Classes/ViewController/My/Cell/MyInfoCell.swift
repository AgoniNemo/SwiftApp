//
//  MyInfoCell.swift
//  SwiftApp
//
//  Created by Nemo on 2017/10/8.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import UIKit

class MyInfoCell: UITableViewCell {

    
    func setModel(model:MyInfoModel) -> Void {
        
        self.textLabel?.text = model.head
        
        self.endLable.text = model.end
        
        
        if model.url.count > 0 {
            self.endView.isHidden = false
            let url = model.url.replacingOccurrences(of: " ", with: "")
            self.endView.kf.setImage(with: URL.init(string: url), placeholder: #imageLiteral(resourceName: "header"))
        }else{
            self.endView.isHidden = true
        }
        
    }
    
    
    class func cell(WithTableView tabView:UITableView) -> MyInfoCell{
        
        let Id = "\(MyInfoCell.description())"
        var cell = tabView.dequeueReusableCell(withIdentifier: Id) as? MyInfoCell
        
        if cell == nil {
            
            cell = MyInfoCell.init(style: .default, reuseIdentifier: Id)
            cell?.accessoryType = .disclosureIndicator
        }
        
        return cell!
        
    }
    
    lazy var endLable: UILabel = {
        
        let h:CGFloat = 30.0
        let y:CGFloat  = (self.height! - h)/2
        let e = UILabel.init(frame: XCGRect(SCREEN_WIDTH - 30 - 100, y, 100,h))
        e.textAlignment = .right
        e.font = UIFont.systemFont(ofSize: 14)
        self.contentView.addSubview(e)
        return e
    }()
    
    lazy var endView: UIImageView = {
        
        let r:CGFloat = 30.0
        let y:CGFloat  = (self.height! - r)/2
        
        let i = UIImageView.init(frame: XCGRect(SCREEN_WIDTH - 30 - r, y, r,r))
        i.layer.masksToBounds = true
        i.layer.cornerRadius = r/2
        self.contentView.addSubview(i)
        return i
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
