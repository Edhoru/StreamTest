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

    weak var listener: BroadcastPresentableListener?
    
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
        
        NSLayoutConstraint.activate([
            playerView.topAnchor.constraint(equalTo: view.topAnchor),
            playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
}
