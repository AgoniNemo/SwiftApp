//
//  UITableView+Extension.swift
//  SwiftApp
//
//  Created by Nemo on 2020/9/24.
//  Copyright © 2020 Nemo. All rights reserved.
//

import UIKit


extension UITableView {
    
    func adjustsScrollView(vc:UIViewController) -> Void {
        
        if #available(iOS 11.0, *) {
            self.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.automatic;
        } else {
            vc.automaticallyAdjustsScrollViewInsets = false;
        }
    }
}
