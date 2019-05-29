//
//  NSAttributedString.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/28/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import UIKit

extension NSAttributedString {
    //This one is used in dynamic cells that need different size based on it's content
    //Current implementation is Neighborhood Reviews
    func heightFitting(width: CGFloat) -> CGFloat {
        let textStorage = NSTextStorage(attributedString: self)
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingRect = CGRect(origin: .zero, size: size)
        
        let textContainer = NSTextContainer(size: size)
        textContainer.lineFragmentPadding = 0
        
        let layoutManager = NSLayoutManager()
        layoutManager.addTextContainer(textContainer)
        
        textStorage.addLayoutManager(layoutManager)
        
        layoutManager.glyphRange(forBoundingRect: boundingRect, in: textContainer)
        
        let rect = layoutManager.usedRect(for: textContainer)
        
        return rect.integral.size.height
    }
    
}
