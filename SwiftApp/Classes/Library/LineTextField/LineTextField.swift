//
//  LineTextField.swift
//  IM
//
//  Created by Nemo on 2016/11/6.
//  Copyright © 2016年 Nemo. All rights reserved.
//

import UIKit

class LineTextField: UITextField {

    
   override init(frame: CGRect) {
    
    super.init(frame: frame);
    
    self.addBottonLine();
    self.textColor = UIColor.white;
    
    }
    
    fileprivate func addBottonLine() {
        
        let view = UIView.init(frame: XCGRect(x: 0, y: self.frame.height+3, width: self.frame.width, height: 1));
        view.backgroundColor = LIGHTCOLOR;
        self.addSubview(view);
    }
    
    func placeholder(color:UIColor,string:String) -> Void {
        self.attributedPlaceholder = NSAttributedString(string:string,attributes: [NSForegroundColorAttributeName: color]);
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        
        
        let inset = XCGRect(x: bounds.origin.x+30, y: bounds.origin.y, width: bounds.size.width+25, height: bounds.size.height);
        
        return inset;
        
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let inset = XCGRect(x: bounds.origin.x+30, y: bounds.origin.y, width: bounds.size.width+25, height: bounds.size.height);
        
        return inset;
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
