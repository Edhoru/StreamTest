//
//  BroadcastTitleView.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/27/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import UIKit

class BroadcastTitleView: UIView {
    
    //Properties
    let title: String
    let views: Int
    let publishedAt: String
    
    //UI
    var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var viewsLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var likesLeftView: LikesLeftView = {
        let view = LikesLeftView(frame: .zero)
        return view
    }()
    
    init(title: String, views: Int, publishedAt: String) {
        self.title = title
        self.views = views
        self.publishedAt = publishedAt
        
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .background
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(likesLeftView)
        
        NSLayoutConstraint.activate([
            likesLeftView.heightAnchor.constraint(equalToConstant: 36),
            likesLeftView.widthAnchor.constraint(equalToConstant: 68),
            likesLeftView.centerYAnchor.constraint(equalTo: centerYAnchor),
            likesLeftView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
            ])
    }

}
