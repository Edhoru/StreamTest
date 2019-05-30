//
//  UserDefaults.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/28/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    var likesToGive: Int {
        get { return value(forKey: #function) as? Int ?? 100 }
        set { set(newValue, forKey: #function) }
    }
    
    var likesGiven: [String : Int] {
        get { return value(forKey: #function) as? [String : Int] ?? [:] }
        set { set(newValue, forKey: #function) }
    }
    
}
