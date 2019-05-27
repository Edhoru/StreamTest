//
//  StreamViewController.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/25/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol StreamPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class StreamViewController: TabBarChildViewController, StreamPresentable {

    weak var listener: StreamPresentableListener?
    
    private var suggestionsContainer: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .background
        return view
    }()
    
    private var broadcastContainer: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .background
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .background
        
        view.addSubview(suggestionsContainer)
        view.addSubview(broadcastContainer)
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            suggestionsContainer.heightAnchor.constraint(equalToConstant: 80),
            suggestionsContainer.topAnchor.constraint(equalTo: safeArea.topAnchor),
            suggestionsContainer.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            suggestionsContainer.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            
            broadcastContainer.topAnchor.constraint(equalTo: suggestionsContainer.bottomAnchor),
            broadcastContainer.leadingAnchor.constraint(equalTo:  safeArea.leadingAnchor),
            broadcastContainer.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            broadcastContainer.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
            ])
    }
    
}


extension StreamViewController: StreamViewControllable {
    
    func displayChildren(suggestions: ViewControllable,
                         broadcast: ViewControllable) {
        guard let suggestionsView = suggestions.uiviewController.view,
            let broadcastView = broadcast.uiviewController.view else {
                return
        }
        
        suggestionsView.translatesAutoresizingMaskIntoConstraints = false
        broadcastView.translatesAutoresizingMaskIntoConstraints = false
        
        suggestionsContainer.addSubview(suggestionsView)
        broadcastContainer.addSubview(broadcastView)
        
        NSLayoutConstraint.activate([
            suggestionsView.topAnchor.constraint(equalTo: suggestionsContainer.topAnchor),
            suggestionsView.leadingAnchor.constraint(equalTo: suggestionsContainer.leadingAnchor),
            suggestionsView.trailingAnchor.constraint(equalTo: suggestionsContainer.trailingAnchor),
            suggestionsView.bottomAnchor.constraint(equalTo: suggestionsContainer.bottomAnchor),
            
            broadcastView.topAnchor.constraint(equalTo: broadcastContainer.topAnchor),
            broadcastView.leadingAnchor.constraint(equalTo: broadcastContainer.leadingAnchor),
            broadcastView.trailingAnchor.constraint(equalTo: broadcastContainer.trailingAnchor),
            broadcastView.bottomAnchor.constraint(equalTo: broadcastContainer.bottomAnchor)
            ])
    }
    
}
