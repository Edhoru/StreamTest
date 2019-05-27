//
//  Stream.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/27/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import Foundation

struct Stream: Codable {
    
    enum State: String, Codable {
        case live
        case none
        case upcoming
    }
    
    var id: String
    var likes: Int
    var publishedAt: String
    var state: State
    var title: String
    var views: Int
    
    /*
    "stream" : {
    "id" : "Xp7t9fWz62Q",
    "publishedAt" : "2019-05-25T21:35:19.000Z",
    "state" : "live",
    "title" : "Stories Of A Stream Sniper!",
    "views" : 500
    }*/
    
}
