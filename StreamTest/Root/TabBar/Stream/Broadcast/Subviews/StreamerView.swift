//
//  StreamerView.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/28/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import UIKit

class StreamerView: UIView {
    
    //Properties
    private enum Constants {
        static let avatar: CGFloat = 48
        static let badge: CGFloat = 17
        static let space: CGFloat = 6
        static let state: CGFloat = 49
    }
    
    //UI
    var avatarImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = Constants.avatar / 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.style(size: 18)
        return label
    }()
    
    var followersLabel: UILabel = {
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
    
    func setup(streamer: Streamer, messageCount: Int) {
        backgroundColor = .background
        
        addSubview(avatarImageView)
        addSubview(nameLabel)
        addSubview(followersLabel)
        addSubview(likesLeftView)
        
        NSLayoutConstraint.activate([
            avatarImageView.heightAnchor.constraint(equalToConstant: Constants.avatar),
            avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            nameLabel.bottomAnchor.constraint(equalTo: centerYAnchor),
            
            followersLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            followersLabel.topAnchor.constraint(equalTo: centerYAnchor, constant: 8),
            
            likesLeftView.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 16),
            likesLeftView.leadingAnchor.constraint(equalTo: followersLabel.trailingAnchor, constant: 16),
            likesLeftView.heightAnchor.constraint(equalToConstant: 36),
            likesLeftView.widthAnchor.constraint(equalToConstant: 68),
            likesLeftView.centerYAnchor.constraint(equalTo: centerYAnchor),
            likesLeftView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
            ])
        
        if let url = URL(string: streamer.avatar) {
            let imageService = ImageService()
            imageService.findImage(with: url) { (image) in
                DispatchQueue.main.async {
                    self.avatarImageView.image = image
                }
            }
        }
        
        nameLabel.text = streamer.name
        
        //Format the number of followers
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        let followers = streamer.followers
        var followersExtension = " followers"
        var followersReduced = followers
        if followers > 1000000 {
            followersExtension = "m followers"
            followersReduced = followers / 1000000
        } else if followers > 1000 {
            followersExtension = "k followers"
            followersReduced = followers / 1000
        }
        let followersNumber = NSNumber(value: followersReduced)
        guard let followersFormatted = formatter.string(from: followersNumber) else { return }
        
        followersLabel.text = "\(followersFormatted) \(followersExtension)"

    }
    
}
