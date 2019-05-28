//
//  LikesLeftView.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/27/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import UIKit

class LikesLeftView: UIView {
    
    var iconImageView: UIImageView = {
        let image = #imageLiteral(resourceName: "icon_star.png").withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .on
        return imageView
    }()
    
    var likesLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.style(size: 17)
        label.textColor = .on
        label.text = UserDefaults.standard.likesToGive.abbreviate()
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .onDark
        layer.cornerRadius = 5
        clipsToBounds = true
        
        addSubview(iconImageView)
        addSubview(likesLabel)
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            likesLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 4),
            likesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            likesLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
