//
//  BroadcastRouter.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/25/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import RIBs

protocol BroadcastInteractable: Interactable, PlayerListener, ChatListener {
    var router: BroadcastRouting? { get set }
    var listener: BroadcastListener? { get set }
}

protocol BroadcastViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func displayChildren(player: ViewControllable,
                         chat: ViewControllable)
    func display(broadcast: Broadcast)
}

final class BroadcastRouter: ViewableRouter<BroadcastInteractable, BroadcastViewControllable> {
    
    let playerBuilder: PlayerBuildable
    let chatBuilder: ChatBuildable
    
    var player: PlayerRouting!
    var chat: ChatRouting!
    
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: BroadcastInteractable,
         viewController: BroadcastViewControllable,
         playerBuilder: PlayerBuildable,
         chatBuilder: ChatBuildable) {
        self.playerBuilder = playerBuilder
        self.chatBuilder = chatBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
        
        attachChildren()
    }
    
    private func attachChildren() {
        player = playerBuilder.build(withListener: interactor)
        attachChild(player)
        
        chat = chatBuilder.build(withListener: interactor)
        attachChild(chat)
        
        viewController.displayChildren(player: player.viewControllable,
                                       chat: chat.viewControllable)
    }
    
}


extension BroadcastRouter: BroadcastRouting {
    
    func set(broadcast: Broadcast) {
        //For RIBs
        player.routeToPlayer(with: broadcast)
        chat.routeToComments(for: broadcast.stream)
        
        //For simple views not created from a RIB
        viewController.display(broadcast: broadcast)
    }
    
}

