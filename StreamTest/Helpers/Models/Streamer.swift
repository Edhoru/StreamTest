//
//  Streamer.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/27/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import Foundation

struct Streamer: Codable {
    
    var id: String
    var avatar: String
    var badge: Int
    var favorite: Bool
    var followers: Int
    var following: Bool
    var likes: Int
    var name: String
    
}
