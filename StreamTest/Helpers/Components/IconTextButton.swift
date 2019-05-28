//
//  IconTextButton.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/28/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import UIKit

class IconTextButton: UIButton {
    
    enum Kind: String {
        case comments = ""
        case share = "Share"
        
        fileprivate var element: Elements {
            get {
                switch self {
                case .comments:
                    return Elements(icon: #imageLiteral(resourceName: "icon_comments.png"), title: "")
                case .share:
                    return Elements(icon: #imageLiteral(resourceName: "icon_share.png"), title: self.rawValue)
                }
            }
        }
    }
    
    fileprivate struct Elements {
        let icon: UIImage
        let title: String
    }
    
    var customTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.style(size: 12)
        label.textColor = .gray
        label.isUserInteractionEnabled = false
        label.textAlignment = .center
        return label
    }()
    
    
    init(kind: IconTextButton.Kind, title: String?) {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let customIconImageView = UIImageView(image: kind.element.icon)
        customIconImageView.translatesAutoresizingMaskIntoConstraints = false
        customIconImageView.contentMode = .scaleAspectFit
        customIconImageView.isUserInteractionEnabled = false
        addSubview(customIconImageView)
        
        customTitleLabel.text = title != nil ? title : kind.rawValue
        addSubview(customTitleLabel)
        
        NSLayoutConstraint.activate([
            customIconImageView.widthAnchor.constraint(equalToConstant: 22),
            customIconImageView.topAnchor.constraint(equalTo: topAnchor),
            customIconImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            customIconImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            customTitleLabel.topAnchor.constraint(greaterThanOrEqualTo: customIconImageView.bottomAnchor),
            customTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            customTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            customTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func custom(title: String) {
        customTitleLabel.text = title
    }
    
}
