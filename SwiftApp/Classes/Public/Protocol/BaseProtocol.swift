//
//  BaseProtocol.swift
//  SwiftApp
//
//  Created by Nemo on 2017/10/1.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import Foundation


@objc protocol BaseVModelDelegate {
    
    func alertInfo(text:String)
    func reloadData()
    func alertload()
}

protocol BaseVModelInterface {
    associatedtype ModelType
    func numberOfRowsInSection(section:Int) -> Int
    func loadingMore()
    func indexPathModel(indexPath:IndexPath) -> ModelType
    func loadLate()
}
