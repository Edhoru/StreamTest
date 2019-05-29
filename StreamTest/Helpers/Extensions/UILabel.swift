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
        self.font = UIFont(name: "DINAlternate-Bold", size: 13)
        self.textAlignment = .center
        self.textColor = .secondary
    }
    
    func styleBadge(size: CGFloat) {
        self.backgroundColor = .red
        self.font = UIFont(name: "DINAlternate-Bold", size: size)
        self.textAlignment = .center
        self.textColor = .secondary
    }
    
    func style(size: CGFloat) {
        self.font = UIFont(name: "DINAlternate-Bold", size: size)
        self.textColor = .secondary
    }
    
}
