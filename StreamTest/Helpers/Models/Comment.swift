//
//  ChatMessage.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/28/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import UIKit

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

extension Comment {
    
    func display() -> NSMutableAttributedString {
        let fontSize: CGFloat = 14
        var font = UIFont.systemFont(ofSize: fontSize)
        if let customFont = UIFont(name: "DINAlternate-Bold", size: fontSize) {
            font = customFont
        }
        
        let commentAttributed = NSMutableAttributedString(string: self.authorDisplayName,
                                                          attributes: [NSAttributedString.Key.font: font,
                                                                       NSAttributedString.Key.foregroundColor: UIColor.secondary])
        let messageAttributed = NSMutableAttributedString(string: "  \(self.textOriginal)",
                                                          attributes: [NSAttributedString.Key.font: font,
                                                                       NSAttributedString.Key.foregroundColor: UIColor.gray])
        commentAttributed.append(messageAttributed)
        return commentAttributed
    }
    
}
