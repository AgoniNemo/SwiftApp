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
    
    // MARK: 时间戳转时间
    static func timeStampToString(timeStamp:String)->String {
        
        let string = NSString(string: timeStamp)
        let timeSta:TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy年MM月dd日"
        
        let date = Date.init(timeIntervalSince1970: timeSta)
        
        print(dfmatter.string(from: date))
        
        return dfmatter.string(from: date)
    }
    
    // MARK: 时间转时间戳
    static func stringToTimeStamp(stringTime:String)->String {
        
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy年MM月dd日"
        let date = dfmatter.date(from: stringTime)
        let dateStamp:TimeInterval = date!.timeIntervalSince1970
        
        return "\(dateStamp)"
    
    }
}

