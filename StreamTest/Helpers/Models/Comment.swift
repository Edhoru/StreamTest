//
//  ChatMessage.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/28/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import Foundation

struct Comment: Codable {
    var id: String
    var authorDisplayName: String
    private var authorProfileImageUrl: String
    var textOriginal: String
    private var publishedAt: String
    
    var avatarUrl: URL? {
        get {
            return URL(string: authorProfileImageUrl)
        }
    }
    
    var publishedAtDate: Date {
        get {
            return publishedAt.jsonDate() ?? Date()
        }
    }
    
}
