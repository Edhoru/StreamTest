//
//  ChatViewController.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/28/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol ChatPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class ChatViewController: UIViewController {

    weak var listener: ChatPresentableListener?
    
    //Properties
    var comments: [Comment] = []
    
    //UI
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 4
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 24, right: 0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .background
        collectionView.register(CommentCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    var bottomImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "chat_bottom.png"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .background
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        view.addSubview(bottomImageView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            bottomImageView.heightAnchor.constraint(equalToConstant: 24),
            bottomImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
}


//UICollectionview DataSource

extension ChatViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let comment = comments[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CommentCollectionViewCell
        cell.backgroundColor = .background
        cell.setup(comment)
        return cell
    }
}

//UICollectionview Delegate

extension ChatViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let elementsHeight: CGFloat = 8
        let width = collectionView.bounds.width - 16
        let comment = comments[indexPath.row]
        let estimatedHeight = comment.display().heightFitting(width: width )
        let height = estimatedHeight + elementsHeight
        view.layoutSubviews()
        return CGSize(width: width, height: height)
    }

}


//RIBs

extension ChatViewController: ChatPresentable {
    
    func startSearch() {
        self.comments = []
        collectionView.reloadData()
    }
    
    func display(comments: [Comment]) {
        var indexPaths: [IndexPath] = []
        
        for i in 0..<self.comments.count {
            indexPaths.append(IndexPath(item: i, section: 0))
        }
        
        collectionView.performBatchUpdates({
            self.collectionView.deleteItems(at: indexPaths)
        }) { (success) in
            self.comments = comments
            self.collectionView.reloadData()
        }
    }
    
    func display(error: Error) {
        print(error)
    }
    
}

extension ChatViewController: ChatViewControllable {
    
}
