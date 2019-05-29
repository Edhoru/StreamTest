//
//  SuggestionsCollectionViewCell.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/25/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import UIKit

class SuggestionsCollectionViewCell: UICollectionViewCell {
    
    enum Layout {
        case big
        case small
    }
    
    //Properties
    private enum Constants {
        static let avatar: CGFloat = 37
        static let avatarXSpace: CGFloat = 16.5
        static let badge: CGFloat = 17
        static let space: CGFloat = 6
        static let state: CGFloat = 49
        static let stateXSpace: CGFloat = 10.5
    }
    
    var broadcast: Broadcast?
    var stateSize: CGFloat = 0
    
    //UI
    private var stateCircleView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .background
        view.layer.cornerRadius = Constants.state / 2
        view.clipsToBounds = true
        return view
    }()
    
    private var avatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "icon_profile"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = Constants.avatar / 2
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "icon_profile.png")
        return imageView
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.styleCell()
        return label
    }()
    
    private var badgeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.styleBadge(size: 18)
        label.layer.cornerRadius = Constants.badge / 2
        label.adjustsFontSizeToFitWidth = true
        label.clipsToBounds = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubview(stateCircleView)
        addSubview(avatarImageView)
        addSubview(nameLabel)
        addSubview(badgeLabel)
        
        NSLayoutConstraint.activate([
            stateCircleView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.space),
            stateCircleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.stateXSpace),
            stateCircleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.stateXSpace),
            stateCircleView.heightAnchor.constraint(equalTo: stateCircleView.widthAnchor),
            stateCircleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.avatarXSpace),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.avatarXSpace),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            avatarImageView.centerXAnchor.constraint(equalTo: stateCircleView.centerXAnchor),
            avatarImageView.centerYAnchor.constraint(equalTo: stateCircleView.centerYAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: stateCircleView.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            badgeLabel.heightAnchor.constraint(equalTo: stateCircleView.heightAnchor, multiplier: 0.33),
            badgeLabel.widthAnchor.constraint(equalTo: badgeLabel.heightAnchor),
            badgeLabel.topAnchor.constraint(equalTo: stateCircleView.topAnchor),
            badgeLabel.trailingAnchor.constraint(equalTo: stateCircleView.trailingAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ broadcast: Broadcast, layout: Layout) {
        backgroundColor = .background
        
        stateSize = self.bounds.width - (Constants.stateXSpace * 2)
        
        stateCircleView.layer.cornerRadius = stateSize / 2
        avatarImageView.layer.cornerRadius = (self.bounds.width - (Constants.avatarXSpace * 2)) / 2
        
        badgeLabel.layer.cornerRadius = (stateSize / 3) / 2
        if layout == .small {
            badgeLabel.styleBadge(size: 12)
        }        
        
        setupAvatar(with: broadcast.streamer.avatar)
        self.broadcast = broadcast
        
        nameLabel.text = broadcast.streamer.name
        nameLabel.textColor = broadcast.stream.state == .none ? .darkGray : broadcast.stream.state == .live ? .gray : .secondary
        badgeLabel.text = broadcast.stream.state == .upcoming ? "" : "\(broadcast.streamer.badge)"
        badgeLabel.backgroundColor = broadcast.stream.state == .upcoming ? .secondary : .badge
        
        setStateView()
    }
    
    private func setupAvatar(with urlString: String?) {
        guard let imageString = urlString,
            let imageURL = URL(string: imageString) else { return }
        
        let imageService = ImageService()
        imageService.findImage(with: imageURL) { (image) in
            DispatchQueue.main.async {
                self.avatarImageView.image = image
            }
        }
    }
    
    
    func setStateView() {
        guard let state = broadcast?.stream.state else { return }
        
        //Let's draw the circle for the background path
        let center = CGPoint(x: stateSize / 2,
                             y: stateSize / 2)
        
        let circularPath = UIBezierPath(arcCenter: center,
                                        radius: stateSize / 2,
                                        startAngle: CGFloat.pi / 4,
                                        endAngle: CGFloat.pi * 2 + CGFloat.pi / 4,
                                        clockwise: true)
        
        let trackLayer = CAShapeLayer()
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.off.cgColor
        trackLayer.lineWidth = 5
        trackLayer.fillColor = UIColor.background.cgColor
        
        stateCircleView.layer.addSublayer(trackLayer)
        
        //Add the circle mask
        guard state != .none else { return }
        
        let stateLayer = CAShapeLayer()
        stateLayer.path = circularPath.cgPath
        stateLayer.strokeColor = UIColor.white.cgColor
        stateLayer.lineWidth = 5
        stateLayer.lineCap = .round
        stateLayer.fillColor = UIColor.clear.cgColor
        stateLayer.strokeEnd = 0
        
        //If the state is new we don't need a gradient, so we just set the state layer line color
        //On the other hand if the state is on we create the gradient
        //For both cases we need the animation
        if state == .upcoming {
            stateLayer.strokeColor = UIColor.secondary.cgColor
            stateCircleView.layer.addSublayer(stateLayer)
        } else {
            let gradientLayer = CAGradientLayer()
            gradientLayer.startPoint = CGPoint(x: 0.2, y: 0.2)
            gradientLayer.endPoint = CGPoint(x: 0.8, y: 0.8)
            gradientLayer.frame = CGRect(x: 0, y: 0, width: stateSize, height: stateSize)
            gradientLayer.colors = [UIColor.on.cgColor, UIColor.purple.cgColor]
            gradientLayer.locations = [0.0, 0.9]
            gradientLayer.mask = stateLayer
            stateCircleView.layer.addSublayer(gradientLayer)
        }
        
        //Animate the mask
        let roundAnimation = CABasicAnimation(keyPath: "strokeEnd")
        roundAnimation.toValue = 1
        roundAnimation.duration = 1
        roundAnimation.fillMode = CAMediaTimingFillMode.forwards
        roundAnimation.isRemovedOnCompletion = false
        stateLayer.add(roundAnimation, forKey: "state")
    }
    
}

