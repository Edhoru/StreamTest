//
//  LikesCountScene.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/29/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import UIKit

class Liking: CATextLayer {
    
    var animationGroup = CAAnimationGroup()
    
    var initialPulseScale: Float = 0
    var nextPulseAfter: TimeInterval = 0
    var animationDuration: TimeInterval = 1.0
    var radius: CGFloat = 200
    let numberOfLoops: Float = 1
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(radius: CGFloat, position: CGPoint, text: String) {
        super.init()
        
        self.fontSize = 20
        self.alignmentMode = .center
        self.opacity = 0
        self.string = "+\(text)"
        
        self.radius = radius
        
        //Random position
        let randomX = position.x + CGFloat(arc4random_uniform(UInt32(radius * 2))) - radius
        self.position = CGPoint(x: randomX, y: position.y)
        
        //Random color
        let colors: [UIColor] = [.cyan, .purple, .green, .yellow, .orange]
        let randomColorIndex = Int(arc4random_uniform(UInt32(colors.count)))
        self.foregroundColor = colors[randomColorIndex].cgColor
        
        self.bounds = CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2)
        self.cornerRadius = radius
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            self.setupAnimationGroup()
            
            DispatchQueue.main.async {
                self.add(self.animationGroup, forKey: "pulse")
            }
        }
    }
    
    func createMoveAnimation() -> CAKeyframeAnimation {
        let positionAnimation = CAKeyframeAnimation(keyPath: "position.y")
        positionAnimation.duration = animationDuration
        positionAnimation.values = [0.0, -150.0, -450.0]
        positionAnimation.keyTimes = [0.0, 0.2, 1.0]
        return positionAnimation
    }
    
    func createOpacityAnimation() -> CAKeyframeAnimation {
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.duration = animationDuration
        opacityAnimation.values = [1.0, 1.0, 0.0]
        opacityAnimation.keyTimes = [0.0, 0.6, 1.0]
        return opacityAnimation
    }
    
    func setupAnimationGroup() {
        self.animationGroup = CAAnimationGroup()
        self.animationGroup.duration = animationDuration + nextPulseAfter
        self.animationGroup.repeatCount = numberOfLoops
        
        let defaultCurve = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.animationGroup.timingFunction = defaultCurve
        
        self.animationGroup.animations = [createMoveAnimation(), createOpacityAnimation()]
    }
    
}
