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
        
        let testview = UIView(frame: .zero)
        testview.translatesAutoresizingMaskIntoConstraints = false
        testview.backgroundColor = .purple
        view.addSubview(testview)
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
    
    func displayChildren(_ suggestions: ViewControllable,
                         broadcast: ViewControllable) {
        suggestionsContainer.addSubview(suggestions.uiviewController.view)
        broadcastContainer.addSubview(broadcast.uiviewController.view)
    }
    
}
