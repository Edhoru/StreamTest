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
    var messagesCount: Int
    var publishedAt: String
    var state: State
    var title: String
    var views: Int
    
    var staticVideoUrl: URL? {
        get {
            //This variable returns apple's video for testing streams
            let fullUrl = "http://devimages.apple.com/iphone/samples/bipbop/gear1/prog_index.m3u8"
            return URL(string: fullUrl)
        }
    }
    
    var videoUrlYT: URL? {
        get {
            let fullUrl = "https://www.youtube.com/watch?v=\(id)"
            return URL(string: fullUrl)
        }
    }
    
    var videoUrl: URL? {
        get {
            let fullUrl = "https://www.youtube.com/embed/\(id)?autoplay=1&amp;playsinline=1"
            return URL(string: fullUrl)
        }
    }
    
}
