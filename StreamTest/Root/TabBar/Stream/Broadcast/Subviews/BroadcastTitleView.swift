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
    
    //UI
    var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.style(size: 20)
        return label
    }()
    
    var viewsLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.style(size: 15)
        label.textColor = .gray
        return label
    }()
    
    var likesLeftView: LikesLeftView = {
        let view = LikesLeftView(frame: .zero)
        return view
    }()
    
    func setup(title: String, views: Int, publishedAt: String) {
        backgroundColor = .background

        addSubview(titleLabel)
        addSubview(viewsLabel)
        addSubview(likesLeftView)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -8),

            viewsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            viewsLabel.topAnchor.constraint(equalTo: centerYAnchor, constant: 8),

            likesLeftView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 16),
            likesLeftView.leadingAnchor.constraint(equalTo: viewsLabel.trailingAnchor, constant: 16),
            likesLeftView.heightAnchor.constraint(equalToConstant: 36),
            likesLeftView.widthAnchor.constraint(equalToConstant: 68),
            likesLeftView.centerYAnchor.constraint(equalTo: centerYAnchor),
            likesLeftView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
            ])

        titleLabel.text = title
        
        //Format the number of views
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        var amountExtension = " views"
        var viewsReduced = views
        if views > 1000000 {
            amountExtension = "m views"
            viewsReduced = views / 1000000
        } else if views > 1000 {
            amountExtension = "k views"
            viewsReduced = views / 1000
        }
        let viewsNumber = NSNumber(value: viewsReduced)
        guard let viewsFormatted = formatter.string(from: viewsNumber) else { return }
        
        //Format the date
        var timePassed = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: publishedAt) {
            print(date)
            
            timePassed = date.timeAgoDisplay
        }
        
        viewsLabel.text = "\(viewsFormatted)\(amountExtension) \(timePassed)"
    }

}
