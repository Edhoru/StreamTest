//
//  BroadcastViewController.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/25/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol BroadcastPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class BroadcastViewController: UIViewController {

    //RIBs
    weak var listener: BroadcastPresentableListener?
    
    //Properties
    
    //UI
    var titleView: BroadcastTitleView = {
        let view = BroadcastTitleView(title: "aa", views: 25, publishedAt: "asd")
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


//RIBs

extension BroadcastViewController: BroadcastPresentable {
    
}

extension BroadcastViewController: BroadcastViewControllable {
    
    func displayChildren(player: ViewControllable) {
        guard let playerView = player.uiviewController.view else {
                return
        }
        playerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(playerView)
        
        
        view.addSubview(titleView)
        
        
        NSLayoutConstraint.activate([
            titleView.heightAnchor.constraint(equalToConstant: 80),
            titleView.topAnchor.constraint(equalTo: view.topAnchor),
            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            playerView.heightAnchor.constraint(equalToConstant: 300),
            playerView.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
    }
    
}
