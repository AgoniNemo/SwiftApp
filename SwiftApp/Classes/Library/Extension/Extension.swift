//
//  Extension.swift
//  IM
//
//  Created by Nemo on 2016/11/17.
//  Copyright © 2016年 Nemo. All rights reserved.
//

import Foundation
import UIKit

extension UIView{

    var x :CGFloat?{
    
        set(x){
            var frame = self.frame;
            frame.origin.x = x!;
            self.frame = frame;
        }
        
        get{
            return self.frame.origin.x;
        }
    
    }
    
    var y :CGFloat?{
        
        set(y){
            var frame = self.frame;
            frame.origin.y = y!;
            self.frame = frame;
        }
        
        get{
            return self.frame.origin.y;
        }
        
    }
    var width :CGFloat?{
        
        set(width){
            var frame = self.frame;
            frame.size.width = width!;
            self.frame = frame;
        }
        
        get{
            return self.frame.size.width;
        }
        
    }
    var height :CGFloat?{
        
        set(height){
            var frame = self.frame;
            frame.size.height = height!;
            self.frame = frame;
        }
        
        get{
            return self.frame.size.height;
        }
        
    }
    
    var maxX:CGFloat?{
        
        set{
            
        }
        
        get{
           return self.frame.maxX
        }
        
    }
    
    var minX:CGFloat?{
        set{
            
        }
        get{
            return self.frame.minX
        }
        
    }
    
    var maxY:CGFloat?{
        set{
            
        }
        get{
            return self.frame.maxY
        }
        
    }
    
    var minY:CGFloat?{
        set{
            
        }
        get{
            return self.frame.minY
        }
        
    }
    var midY:CGFloat?{
        set{
            
        }
        get{
            return self.frame.midY
        }
        
    }
    var midX:CGFloat?{
        set{
            
        }
        get{
            return self.frame.midX
        }
        
    }
    /**
    @IBInspectable var normalColor: UIColor {
        get {
            return objc_getAssociatedObject(self, "x_normalColor") as! UIColor
        }
        set(newValue) {
            objc_setAssociatedObject(self, "x_normalColor", newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }*/
    

}
