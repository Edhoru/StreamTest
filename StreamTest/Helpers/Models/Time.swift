//
//  Time.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/28/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import Foundation


struct Time {
    
    struct Metric {
        
        var value: Int
        var singular: String
        var plural: String
        
        func display(_ v: Int) -> String {
            let valueDisplay = v / value
            let measure: String = valueDisplay == 1 ? singular : plural
            
            return String(format: "%@ %@ ago", "\(valueDisplay)", measure)
        }
    }
    
    
    static let second: Metric = {
        Metric(value: 0,
               singular: "second",
               plural: "seconds")
    }()
    
    static let minute: Metric = {
        Metric(value: 60,
               singular: "minute",
               plural: "minutes")
    }()
    
    static let hour: Metric = {
        Metric(value: minute.value * 60,
               singular: "hour",
               plural: "hours")
    }()
    
    static let day: Metric = {
        Metric(value: hour.value * 24,
               singular: "day",
               plural: "days")
    }()
    
    static let week: Metric = {
        Metric(value: day.value * 7,
               singular: "week",
               plural: "weeks")
    }()
    
    static let month: Metric = {
        Metric(value: day.value * 30,
               singular: "month",
               plural: "months")
    }()
    
    static let year: Metric = {
        Metric(value: day.value * 365,
               singular: "year",
               plural: "years")
    }()
    
}
