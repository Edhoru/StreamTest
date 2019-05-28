//
//  String.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/28/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import Foundation

extension String {
    
    func jsonDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        guard let date = dateFormatter.date(from: self) else {
            return nil
        }
        
        return date
    }
    
}
