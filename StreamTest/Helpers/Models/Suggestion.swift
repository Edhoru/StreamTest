//
//  Suggestion.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/25/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import UIKit

struct Suggestion {
    
    enum State {
        case on
        case off
        case new
    }
    
    var avatar: UIImage
    var badge: Int
    var color: UIColor //This one is a placeholder that won't be helpful once the full model is setup
    var name: String
    var state: State
    
    init(avatar: UIImage = #imageLiteral(resourceName: "icon_profile.png"),
         badge: Int,
         color: UIColor,
         name: String,
         state: Suggestion.State) {
        self.avatar = avatar
        self.badge = state == .new ? 10 : badge
        self.color = color
        self.name = name
        self.state = state
    }
}
