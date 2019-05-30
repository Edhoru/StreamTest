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
    var streamer: Streamer?
    
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
    
    var shareButton: IconTextButton = {
        let button = IconTextButton(kind: .share, title: nil)
        return button
    }()
    
    var commentsButton: IconTextButton = {
        let button = IconTextButton(kind: .comments, title: nil)
        return button
    }()
    
    var likeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setImage(#imageLiteral(resourceName: "star_big").withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.tintColor = .on
        button.layer.cornerRadius = 28
        button.clipsToBounds = true
        return button
    }()
    
    var likeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.style(size: 15)
        label.textColor = .on
        label.textAlignment = .center
        return label
    }()
    
    func setup(streamer: Streamer, messageCount: Int) {
        backgroundColor = .background
        
        self.streamer = streamer
        
        shareButton.addTarget(self, action: #selector(shareAction), for: .touchUpInside)
        commentsButton.addTarget(self, action: #selector(commentsAction), for: .touchUpInside)
        likeButton.addTarget(self, action: #selector(likeAction), for: .touchDown)
        
        nameLabel.text = streamer.name
        followersLabel.text = "\(streamer.followers.abbreviate()) followers"
        commentsButton.custom(title: "\(messageCount)")
        displayLikes()
        
        addSubview(avatarImageView)
        addSubview(nameLabel)
        addSubview(followersLabel)
        addSubview(shareButton)
        addSubview(commentsButton)
        addSubview(likeButton)
        addSubview(likeLabel)
        
        NSLayoutConstraint.activate([
            avatarImageView.heightAnchor.constraint(equalToConstant: Constants.avatar),
            avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 8),
            nameLabel.bottomAnchor.constraint(equalTo: centerYAnchor),
            
            followersLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 8),
            followersLabel.topAnchor.constraint(equalTo: centerYAnchor, constant: 8),
            
            shareButton.widthAnchor.constraint(equalToConstant: 36),
            shareButton.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            shareButton.bottomAnchor.constraint(equalTo: followersLabel.bottomAnchor),
            shareButton.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8),
            shareButton.leadingAnchor.constraint(equalTo: followersLabel.trailingAnchor, constant: 8),
            
            commentsButton.widthAnchor.constraint(equalToConstant: 36),
            commentsButton.topAnchor.constraint(equalTo: shareButton.topAnchor),
            commentsButton.bottomAnchor.constraint(equalTo: shareButton.bottomAnchor),
            commentsButton.leadingAnchor.constraint(equalTo: shareButton.trailingAnchor, constant: 8),
            
            likeButton.topAnchor.constraint(equalTo: topAnchor),
            likeButton.heightAnchor.constraint(equalToConstant: 56),
            likeButton.widthAnchor.constraint(equalToConstant: 56),
            likeButton.leadingAnchor.constraint(equalTo: commentsButton.trailingAnchor, constant: 16),
            likeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            likeLabel.topAnchor.constraint(equalTo: likeButton.bottomAnchor, constant: 8),
            likeLabel.leadingAnchor.constraint(equalTo: likeButton.leadingAnchor),
            likeLabel.trailingAnchor.constraint(equalTo: likeButton.trailingAnchor),
            likeLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        
        if let url = URL(string: streamer.avatar) {
            let imageService = ImageService()
            imageService.findImage(with: url) { (image) in
                DispatchQueue.main.async {
                    self.avatarImageView.image = image
                }
            }
        }
    }
    
    func displayLikes() {
        guard let streamer = self.streamer else {
            likeLabel.text = "0"
            return
        }
        
        let likesFromJSON = streamer.likes
        let likesGiven = UserDefaults.standard.likesGiven[streamer.id] ?? 0
        let totalLikes = likesFromJSON + likesGiven
        likeLabel.text = "\(totalLikes.abbreviate())"
    }
    
    //Actions
    
    @objc func shareAction() {
        print("shareAction()")
    }
    
    @objc func commentsAction() {
        print("commentsAction()")
    }
    
    @objc func likeAction() {
        guard UserDefaults.standard.likesToGive > 0,
        let streamer = self.streamer else { return }
        
        NotificationCenter.default.post(name: .videoLiked, object: streamer)
        
        let pulse = Pulsing(numberOfPulses: 1, radius: 120, position: likeButton.center)
        pulse.animationDuration = 0.8
        
        layer.insertSublayer(pulse, below: likeButton.layer)
        
        let likesGiven = UserDefaults.standard.likesGiven[streamer.id] ?? 0
        let liking = Liking(radius: likeButton.bounds.width / 2, position: likeButton.center, text: "\(likesGiven)")
        liking.animationDuration = 1.5
        
        layer.insertSublayer(liking, below: likeButton.layer)
    }
    
}
