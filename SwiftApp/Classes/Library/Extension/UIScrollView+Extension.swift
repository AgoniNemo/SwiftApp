//
//  UIScrollView+Extension.swift
//  SwiftApp
//
//  Created by Mjwon on 2017/10/17.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import Foundation
import UIKit
import ESPullToRefresh


extension UIScrollView {
    
    func addPullToRefresh(handler:@escaping (()->())) -> Void {
        self.es_addPullToRefresh {
            handler()
        }
    }
    
    func addInfiniteScrolling(handler:@escaping (()->())) -> Void {
        self.es_addInfiniteScrolling {
            handler()
        }
    }
    
    func stopLoadingMore() -> Void {
        self.es_stopLoadingMore()
    }
    func stopPullToRefresh(ignoreDate: Bool = false, ignoreFooter: Bool = false) -> Void {
        self.es_stopPullToRefresh(ignoreDate: ignoreDate, ignoreFooter: ignoreFooter)
    }
}
