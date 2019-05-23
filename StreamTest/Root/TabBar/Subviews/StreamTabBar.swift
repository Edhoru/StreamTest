//
//  TabBar.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/22/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import UIKit

protocol StreamTabBarDelegate: class {
    func selected(tab: Int)
}

class StreamTabBar: UIView {
    
    weak var delegate: StreamTabBarDelegate?
    
    private var children: [TabBarChildViewController]!
    private var selectedButton: UIButton!
    
    init(children: [TabBarChildViewController]) {
        super.init(frame: .zero)
        
        self.children = children
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .background
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        var lastButton: UIButton!
        let edgeConstant: CGFloat = 30
        let size: CGFloat = 20
        
        children.forEach { (child) in
            let image = child.icon.withRenderingMode(.alwaysTemplate)
            
            let button = UIButton(type: .custom)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(image, for: .normal)
            button.imageView?.contentMode = .scaleAspectFit
            button.tag  = self.subviews.count
            button.addTarget(self, action: #selector(select(sender:)), for: .touchUpInside)
            
            addSubview(button)
            
            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: topAnchor, constant: edgeConstant / 2),
                button.heightAnchor.constraint(equalToConstant: size)
                ])
            
            if lastButton == nil {
                button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: edgeConstant).isActive = true
                selectedButton = button
                color(button: button, selected: true)
            } else {
                button.leadingAnchor.constraint(equalTo: lastButton.trailingAnchor, constant: edgeConstant / 2).isActive = true
                button.widthAnchor.constraint(equalTo: lastButton.widthAnchor).isActive = true
                color(button: button, selected: false)
            }
            
            lastButton = button
        }
        
        lastButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -edgeConstant).isActive = true
    }
    
    
    @objc private func select(sender: UIButton) {
        color(button: selectedButton, selected: false)
        color(button: sender, selected: true)
        
        selectedButton = sender
        
        delegate?.selected(tab: sender.tag)
    }
    
    private func color(button: UIButton, selected: Bool) {
        button.imageView?.tintColor = selected == true ? .white : .gray
        button.isUserInteractionEnabled = selected == true ? false : true
    }
}
