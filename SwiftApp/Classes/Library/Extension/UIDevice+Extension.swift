//
//  UIDevice+Extension.swift
//  SwiftApp
//
//  Created by Mjwon on 2017/12/22.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import UIKit

extension UIDevice {
    public func isX() -> Bool {
        if UIScreen.main.bounds.height == 812 {
            return true
        }
        return false
    }
}
