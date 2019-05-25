//
//  SuggestionsViewController.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/25/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol SuggestionsPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class SuggestionsViewController: UIViewController, SuggestionsViewControllable {
    
    weak var listener: SuggestionsPresentableListener?
    
    //Properties
    var suggestions: [Suggestion] = []
    
    //UI
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 70, height: 80)
        layout.minimumInteritemSpacing = 4
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .background
        collectionView.register(SuggestionsCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .red
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
}


// CollectionView
extension SuggestionsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return suggestions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let suggestion = suggestions[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SuggestionsCollectionViewCell
        cell.setup(suggestion)
        return cell
    }
    
}

extension SuggestionsViewController: UICollectionViewDelegate {
    
}


//RIBs

extension SuggestionsViewController: SuggestionsPresentable {
    
    func display(suggestions: [Suggestion]) {
        self.suggestions = suggestions
        collectionView.reloadData()
    }
    
}
