//
//  CommentCollectionViewCell.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/28/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import UIKit

class CommentCollectionViewCell: UICollectionViewCell {
    
    
    //UI
    var commentLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubview(commentLabel)
        
        NSLayoutConstraint.activate([
            commentLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            commentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            commentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 4),
            commentLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 4)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ comment: Comment) {
        print(commentLabel)
        commentLabel.text = comment.authorDisplayName + "  " + comment.textOriginal
        print(commentLabel)
    }
}
