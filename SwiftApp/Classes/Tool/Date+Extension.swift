//
//  Date+Extension.swift
//  VaporApp
//
//  Created by Mjwon on 2017/8/25.
//
//

import Foundation
import UIKit


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
    static func timeStampToString(timeStamp:String,dateFormat:String? = "yyyy年MM月dd日 HH:mm")->String {
        
        let string = NSString(string: timeStamp)
        let timeSta:TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        // yyyy年MM月dd日 HH:mm:ss
        dfmatter.dateFormat = dateFormat
        
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
    
    static func formattedDateDescription(stringTime:String) -> String {
        
        let timeInterval = Date().timeIntervalSince1970
        
        let theDay = self.timeStampToString(timeStamp: stringTime,dateFormat: "yyyy年MM月dd日")
        let currentDay = self.timeStampToString(timeStamp: "\(timeInterval)",dateFormat: "yyyy年MM月dd日")
        
        let v = Float(timeInterval) - NSString.init(string: stringTime).floatValue
        
        if v < 60 {
            return "刚刚"
        }else if (v < 3600){ // 1小时
            return "\(Int(v/60))分钟前"
        }else if (v < 21600){ // 6小时
            return "\(Int(v/3600))小时前"
        }else if ((v < 3600 * 24) && theDay == currentDay){
            return "今天"
        }else if (v < 3600 * 48){
            return "昨天"
        }
        
        return self.stringToTimeStamp(stringTime:stringTime)
    }
}

