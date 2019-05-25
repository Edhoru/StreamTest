//
//  SuggestionsCollectionViewCell.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/25/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import UIKit

class SuggestionsCollectionViewCell: UICollectionViewCell {
    
    //Properties
    private enum Constants {
        static let avatar: CGFloat = 37
        static let badge: CGFloat = 17
        static let space: CGFloat = 6
        static let state: CGFloat = 49
    }
    
    var suggestion: Suggestion?
    
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
        return imageView
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private var badgeView: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .red
        label.textColor = .white
        label.textAlignment = .center
        label.layer.cornerRadius = Constants.badge / 2
        label.clipsToBounds = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubview(stateCircleView)
        addSubview(avatarImageView)
        addSubview(nameLabel)
        addSubview(badgeView)
        
        NSLayoutConstraint.activate([
            stateCircleView.heightAnchor.constraint(equalToConstant: Constants.state),
            stateCircleView.widthAnchor.constraint(equalTo: stateCircleView.heightAnchor),
            stateCircleView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.space),
            stateCircleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            avatarImageView.heightAnchor.constraint(equalToConstant: Constants.avatar),
            avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor),
            avatarImageView.centerXAnchor.constraint(equalTo: stateCircleView.centerXAnchor),
            avatarImageView.centerYAnchor.constraint(equalTo: stateCircleView.centerYAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: stateCircleView.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            badgeView.heightAnchor.constraint(equalToConstant: Constants.badge),
            badgeView.widthAnchor.constraint(equalTo: badgeView.heightAnchor),
            badgeView.topAnchor.constraint(equalTo: stateCircleView.topAnchor),
            badgeView.trailingAnchor.constraint(equalTo: stateCircleView.trailingAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ suggestion: Suggestion) {
        backgroundColor = .background
        
        self.suggestion = suggestion
        
        stateCircleView.backgroundColor = suggestion.color
        avatarImageView.image = suggestion.avatar
        nameLabel.text = suggestion.name
        nameLabel.textColor = suggestion.state == .off ? .gray : .white
        badgeView.text = suggestion.state == .new ? "" : "\(suggestion.badge)"
        badgeView.backgroundColor = suggestion.state == .new ? .white : .badge
        
        setStateView()
    }
    
    func setStateView() {
        guard let state = suggestion?.state else { return }
        
        //Let's draw the circle for the background path
        let center = CGPoint(x: Constants.state / 2,
                             y: Constants.state / 2)
        
        let circularPath = UIBezierPath(arcCenter: center,
                                        radius: Constants.state/2,
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
        guard state != .off else { return }
        
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
        if state == .new {
            stateLayer.strokeColor = UIColor.white.cgColor
            stateCircleView.layer.addSublayer(stateLayer)
        } else {
            let gradientLayer = CAGradientLayer()
            gradientLayer.startPoint = CGPoint(x: 0.2, y: 0.2)
            gradientLayer.endPoint = CGPoint(x: 0.8, y: 0.8)
            gradientLayer.frame = CGRect(x: 0, y: 0, width: 49, height: 49)
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

