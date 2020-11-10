//
//  HisAColVModel.swift
//  SwiftApp
//
//  Created by Nemo on 2017/10/7.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import Foundation


protocol HisAColVModelDelegate:BaseVModelDelegate {
    
}

private protocol HisAColVModelInterface:BaseVModelInterface {
    
    var delegate: HisAColVModelDelegate? { get set }
    func loadAll()
    func delete(row:Int)
}

class HisAColVModel:HisAColVModelInterface {
    
    weak var delegate: HisAColVModelDelegate?
    
    private var dataSorce:[HisAColModel] = Array.init()
    private var his:Bool = true
    
    init(_ his:Bool? = true) {
        self.his = his!
    }
    
    func loadLate() {
        
    }
    
    func delete(row: Int) {
        
        let model = dataSorce[row]
        var b = false
        if self.his {
           b = model.deleteHistory()
        }else{
           b = model.deleteCollect()
        }
        if b {
            dataSorce.remove(at: row)
            self.delegate?.reloadData()
        }
        
    }
    
    func loadAll() {
        
        let list = self.his ? HisAColModel.allHistory() : HisAColModel.allCollect()
        for val in list.enumerated() {
            let dict = val.element
            
            let model = HisAColModel.init(dict: dict)
            self.dataSorce.append(model)
        }
        XLogLine(list)
        
        self.delegate?.reloadData()
    }
    
    
    func indexPathModel(indexPath: IndexPath) -> HisAColModel {
        
        return self.dataSorce[indexPath.row]
        
    }
    
    func numberOfRowsInSection(section:Int) -> Int {
        
        return self.dataSorce.count
    }
    
    func loadingMore() {
        
    }
    
    
}
