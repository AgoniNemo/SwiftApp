//
//  MyCell.swift
//  SwiftApp
//
//  Created by Nemo on 2017/10/2.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import UIKit

class MyCell: UITableViewCell {

    
    func setModel(dict:[String:String]) -> Void {
        
        self.textLabel?.text = dict["name"]
        self.contentView.addSubview(self.endView)
    }
    
    class func cell(WithTableView tabView:UITableView) -> MyCell{
        
        let Id = "\(HomeCell.description())"
        var cell = tabView.dequeueReusableCell(withIdentifier: Id) as? MyCell
        
        if cell == nil {
            
            cell = MyCell.init(style: .default, reuseIdentifier: Id)
        }
        
        return cell!
        
    }
    
    lazy var endView: UIImageView = {
        let h:CGFloat = 19.5
        let y:CGFloat  = (self.height! - h)/2
        let i = UIImageView.init(frame: XCGRect(SCREEN_WIDTH-20, y, 10.5,h))
        i.image = #imageLiteral(resourceName: "CellArrow")
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
