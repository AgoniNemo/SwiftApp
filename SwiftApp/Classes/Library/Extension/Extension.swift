//
//  Extension.swift
//  IM
//
//  Created by Nemo on 2016/11/17.
//  Copyright © 2016年 Nemo. All rights reserved.
//

import Foundation
import UIKit

var x : CGFloat?
var y : CGFloat?
var width : CGFloat?
var height : CGFloat?

extension UIView{

    var x :CGFloat?{
    
        set{
            var frame = self.frame;
            frame.origin.x = x!;
            self.frame = frame;
        }
        
        get{
            return self.frame.origin.x;
        }
    
    }
    
    var y :CGFloat?{
        
        set{
            var frame = self.frame;
            frame.origin.y = y!;
            self.frame = frame;
        }
        
        get{
            return self.frame.origin.y;
        }
        
    }
    var width :CGFloat?{
        
        set{
            var frame = self.frame;
            frame.size.width = width!;
            self.frame = frame;
        }
        
        get{
            return self.frame.size.width;
        }
        
    }
    var height :CGFloat?{
        
        set{
            var frame = self.frame;
            frame.size.height = height!;
            self.frame = frame;
        }
        
        get{
            return self.frame.size.height;
        }
        
    }

}
