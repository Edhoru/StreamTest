//
//  UILabel.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/25/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import UIKit

extension UILabel {
    
    func styleCell() {
        self.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        self.textAlignment = .center
        self.textColor = .secondary
    }
    
    func styleBadge() {
        self.backgroundColor = .red
        self.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        self.textAlignment = .center
        self.textColor = .secondary
    }
}
