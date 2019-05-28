//
//  Date.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/28/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import Foundation


extension Date {
    
    var timeAgoDisplay: String {
        
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        if secondsAgo < Time.minute.value {
            return Time.second.display(secondsAgo)
        } else if secondsAgo < Time.hour.value {
            return Time.minute.display(secondsAgo)
        } else if secondsAgo < Time.day.value {
            return Time.hour.display(secondsAgo)
        } else if secondsAgo < Time.week.value {
            return Time.day.display(secondsAgo)
        } else if secondsAgo < Time.month.value {
            return Time.week.display(secondsAgo)
        } else if secondsAgo < Time.year.value {
            return Time.month.display(secondsAgo)
        } else {
            return Time.year.display(secondsAgo)
        }
    }

}
