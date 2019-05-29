//
//  LikeButton.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/29/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import UIKit

@IBDesignable

class LikeButton: UIButton {
    var mainLayer: CAShapeLayer?
    var animationGroup: CAAnimationGroup?
    @IBInspectable var pulseColor: UIColor?
    @IBInspectable var pulseRadius: CGFloat = 0.0
    @IBInspectable var pulseDuration: CGFloat = 0.0
    @IBInspectable var buttonColor: UIColor?
    @IBInspectable var cornerRadius: CGFloat = 0.0
    
    
    init(frame: CGRect, andBackgroundColor backgroundColor: UIColor?) {
        super.init(frame: frame)
        buttonColor = backgroundColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setup()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        let pulse: CAShapeLayer? = createPulse()
        if let pulse = pulse {
            layer.insertSublayer(pulse, below: mainLayer)
        }
        
        DispatchQueue.global(qos: .default).async(execute: {
            //Background Thread
            self.createAnimationGroup()
            
            guard let animationGroup = self.animationGroup else { return }
            DispatchQueue.main.sync(execute: {
                pulse?.add(animationGroup, forKey: "pulse")
            })
        })
        
    }
    
    func setup() {
        mainLayer?.backgroundColor = buttonColor?.cgColor
        mainLayer?.bounds = bounds
        mainLayer?.cornerRadius = cornerRadius
        mainLayer?.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        mainLayer?.zPosition = -1
        
        if mainLayer != nil {
            layer.addSublayer(mainLayer!)
        }
    }
    
    func createPulse() -> CAShapeLayer? {
        let pulse = CAShapeLayer()
        pulse.backgroundColor = pulseColor?.cgColor
        pulse.contentsScale = UIScreen.main.scale
        pulse.bounds = bounds
        pulse.cornerRadius = cornerRadius
        pulse.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        pulse.zPosition = -2
        pulse.opacity = 0
        return pulse
    }
    
    func createAnimationGroup() {
        animationGroup = CAAnimationGroup()
        animationGroup?.animations = [createScaleAnimation(), createOpacityAnimation()] as? [CAAnimation]
        animationGroup?.duration = CFTimeInterval(pulseDuration)
    }
    
    func createScaleAnimation() -> CABasicAnimation? {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.xy")
        scaleAnimation.fromValue = NSNumber(value: 1)
        scaleAnimation.toValue = NSNumber(value: ((Double(pulseRadius)) / 10) + 1.0)
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        return scaleAnimation
    }
    
    func createOpacityAnimation() -> CAKeyframeAnimation? {
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.values = [NSNumber(value: 0.8), NSNumber(value: 0.4), NSNumber(value: 0)] //[[NSNumber numberWithFloat:0.8], [NSNumber numberWithFloat:0.4],[NSNumber numberWithFloat:0]];
        opacityAnimation.keyTimes = [NSNumber(value: 0), NSNumber(value: 0.5), NSNumber(value: 1)]
        opacityAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        return opacityAnimation
    }
    
    // MARK: - Setters
    func setButtonColor(_ buttonColor: UIColor?) {
        self.buttonColor = buttonColor
        layer.backgroundColor = buttonColor?.cgColor
    }
    
    func setCornerRadius(_ cornerRadius: CGFloat) {
        self.cornerRadius = cornerRadius
        layer.cornerRadius = cornerRadius
    }
}

