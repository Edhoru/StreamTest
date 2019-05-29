//
//  CommentCollectionViewCell.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/28/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import UIKit

class CommentCollectionViewCell: UICollectionViewCell {
    
    //Properties
    var comment: Comment?
    
    //UI
    var commentLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubview(commentLabel)
        
        NSLayoutConstraint.activate([
            commentLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            commentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            commentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 8),
            commentLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 4)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ comment: Comment) {
        self.comment = comment
        commentLabel.attributedText = comment.display()
    }
    
}
