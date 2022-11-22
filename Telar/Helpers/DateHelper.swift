//
//  DateHelper.swift
//  Telar
//
//  Created by Romesh Singhabahu on 11/09/22.
//

import Foundation

class DateHelper {
    
    static func chatTimeStampFrom(date: Date?) -> String {
        
        guard date != nil else {
            return ""
        }
        
        let df = DateFormatter()
        df.dateFormat = "HH:mm"
        
        return df.string(from: date!)
    }
}
