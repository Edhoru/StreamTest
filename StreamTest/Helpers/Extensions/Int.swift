//
//  Int.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/28/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import Foundation

extension Int {
    
    func abbreviate() -> String {
        //Format the number of views
        let floatValue = Float(self)
        var ending = ""
        var reduced = floatValue
        
        if floatValue > 1000000 {
            ending = "m"
            reduced = floatValue / 1000000
        } else if floatValue > 1000 {
            ending = "k"
            reduced = floatValue / 1000
        }
        
        let reducedString = String(format: "%.1f", reduced) + ending
        return reducedString.replacingOccurrences(of: ".0", with: "")
    }
    
}
