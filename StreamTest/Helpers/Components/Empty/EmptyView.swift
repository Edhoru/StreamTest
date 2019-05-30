//
//  EmptyView.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/29/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import UIKit
import Lottie

class EmptyView: UIView {
    
    enum Kind {
        case search
        case notifications
        case profile
        
        fileprivate struct EmptyInfo {
            var file: String
            var message: String
        }
        
        fileprivate var info: EmptyInfo {
            get {
                switch self {
                case .search:
                    return EmptyInfo(file: "empty-box",
                                     message: "Nothing to find here")
                case .notifications:
                    return EmptyInfo(file: "no-notifications",
                                     message: "Shhh! zzz")
                case .profile:
                    return EmptyInfo(file: "funky-chicken",
                                     message: "Imagine a profile as funky as this chicken")
                }
            }
        }
    }
    
    var animationView: AnimationView = {
        let animationView = AnimationView(frame: .zero)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.loopMode = .loop
        return animationView
    }()
    
    var messageLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.style(size: 28)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    init(kind: EmptyView.Kind) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .background
        
        addSubview(animationView)
        addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.9),
            animationView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.9),
            animationView.centerXAnchor.constraint(equalTo: centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            messageLabel.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 16),
            messageLabel.leadingAnchor.constraint(equalTo: animationView.leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: animationView.trailingAnchor, constant: -16)
            ])
        
        let animation = Animation.named(kind.info.file)
        animationView.animation = animation
        animationView.play()
        
        messageLabel.text = kind.info.message
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func stopAnimation() {
        animationView.stop()
    }
    
}

