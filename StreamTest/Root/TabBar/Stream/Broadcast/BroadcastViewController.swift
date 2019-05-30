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
        let view = BroadcastTitleView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var streamerView: StreamerView = {
        let view = StreamerView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
    }
}


//RIBs

extension BroadcastViewController: BroadcastPresentable {
    
    func updateLikeCount() {
        titleView.likesLeftView.display()
        streamerView.displayLikes()
    }
}

extension BroadcastViewController: BroadcastViewControllable {
    
    func displayChildren(player: ViewControllable,
                         chat: ViewControllable) {
        guard let playerView = player.uiviewController.view,
        let chatView = chat.uiviewController.view else {
                return
        }
        
        playerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(playerView)
        
        chatView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(chatView)
        
        view.addSubview(titleView)
        view.addSubview(streamerView)
        
        NSLayoutConstraint.activate([
            titleView.heightAnchor.constraint(equalToConstant: 80),
            titleView.topAnchor.constraint(equalTo: view.topAnchor),
            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            playerView.heightAnchor.constraint(equalToConstant: 300),
            playerView.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            chatView.topAnchor.constraint(equalTo: playerView.bottomAnchor),
            chatView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chatView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            streamerView.heightAnchor.constraint(equalToConstant: 80),
            streamerView.topAnchor.constraint(equalTo: chatView.bottomAnchor),
            streamerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            streamerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            streamerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
        
    }
    
    func display(broadcast: Broadcast) {
        titleView.setup(title: broadcast.stream.title,
                        views: broadcast.stream.views,
                        publishedAt: broadcast.stream.publishedAt)
        
        streamerView.setup(streamer: broadcast.streamer,
                           messageCount: broadcast.stream.messagesCount)
    }
    
}
