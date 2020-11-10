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
        self.es.addPullToRefresh {
            [unowned self] in
            /// 在这里做刷新相关事件
            /// ...
            /// 如果你的刷新事件成功，设置completion自动重置footer的状态
            self.es.stopPullToRefresh(ignoreDate: true)
            /// 设置ignoreFooter来处理不需要显示footer的情况
            self.es.stopPullToRefresh(ignoreDate: true, ignoreFooter: false)
            handler()
        }
    }
    
    func addInfiniteScrolling(handler:@escaping (()->())) -> Void {
        self.es.addInfiniteScrolling {
            [unowned self] in
            /// 在这里做加载更多相关事件
            /// ...
            /// 如果你的加载更多事件成功，调用es_stopLoadingMore()重置footer状态
            self.es.stopLoadingMore()
            /// 通过es_noticeNoMoreData()设置footer暂无数据状态
            self.es.noticeNoMoreData()
            handler()
        }
    }
    
    func stopLoadingMore() -> Void {
        self.es.stopLoadingMore()
    }
    
    func stopPullToRefresh(ignoreDate: Bool = false, ignoreFooter: Bool = false) -> Void {
        self.es.stopPullToRefresh(ignoreDate: ignoreDate, ignoreFooter: ignoreFooter)
    }
}
