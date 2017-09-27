//
//  Date+Extension.swift
//  VaporApp
//
//  Created by Mjwon on 2017/8/25.
//
//

import Foundation



extension Date{

    static func intTimestamp() -> Int{
        let now = Date().timeIntervalSince1970;
        let time:Int = Int(String.init(format: "%.f", now))!;
        return time;
    }
    
    static func stringTimestamp() -> String{
        let now = Date().timeIntervalSince1970;
        let time = String.init(format: "%.f", now);
        return time;
    }
    
    static func contrastDate(time:String) -> Bool{
    
        let now = Date().timeIntervalSince1970;
        
        let value = now - Double(time)!
        
        debugPrint(value)
        
        if value > (2 * 24 * 60 * 60) {
            
            return true
        }

        return false
    }
    
    func string() -> String{
    
        let string = self.timeIntervalSince1970
        
        return String.init(format: "%.f", string)
    }
    
    
}
