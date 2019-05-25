//
//  SuggestionsDataService.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/25/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import Foundation

class SuggestionsDataService {
    
    func get(_ completion: @escaping ([Suggestion], Error?) -> Void) {
        let suggestions: [Suggestion] = [
            Suggestion(badge: 0, color: .green, name: "Feed", state: .on),
            Suggestion(badge: 2, color: .red, name: "Ninja", state: .new),
            Suggestion(badge: 3, color: .blue, name: "3", state: .on),
            Suggestion(badge: 0, color: .orange, name: "4", state: .on),
            Suggestion(badge: 5, color: .on, name: "5", state: .off),
            Suggestion(badge: 1, color: .brown, name: "6", state: .off),
            Suggestion(badge: 0, color: .purple, name: "7", state: .on),
            Suggestion(badge: 8, color: .white, name: "8", state: .off),
            Suggestion(badge: 9, color: .cyan, name: "9", state: .off)
        ]
        completion(suggestions, nil)
    }
}
