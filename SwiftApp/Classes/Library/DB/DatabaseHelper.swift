//
//  DatabaseHelper.swift
//  IM
//
//  Created by Mjwon on 2017/7/19.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import UIKit
import FMDB


final class DatabaseHelper: NSObject{

    static let sharedInstance = DatabaseHelper()
    
    private var queue:FMDatabaseQueue?;
    
    
    private override init() {
        super.init();
        let path = self.getDataBasePath();
        self.queue = FMDatabaseQueue.init(path: path);
    }
    
    private func getDataBasePath() -> String {
        
        let array = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        let path = "\(array[0])/DataStore.db";
        XLogLine(path)
        
        return path;
    }
    
    lazy var userMager:UserInformationManager = {
    
        let user:UserInformationManager = UserInformationManager.userInformationManagerForQueue(queue: self.queue!);
        
        return user;
    
    }()
    
    lazy var videoMager:VideoManager = {
        
        let video:VideoManager = VideoManager.videoManagerForQueue(queue: self.queue!);
        
        return video;
        
    }()
    
}
