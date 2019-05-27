//
//  BroadcastRouter.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/25/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import RIBs

protocol BroadcastInteractable: Interactable, PlayerListener {
    var router: BroadcastRouting? { get set }
    var listener: BroadcastListener? { get set }
}

protocol BroadcastViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func displayChildren(player: ViewControllable)
}

final class BroadcastRouter: ViewableRouter<BroadcastInteractable, BroadcastViewControllable>, BroadcastRouting {

    let playerBuilder: PlayerBuildable
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: BroadcastInteractable,
                  viewController: BroadcastViewControllable,
                  playerBuilder: PlayerBuildable) {
        self.playerBuilder = playerBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
        
        attachChildren()
    }
    
    private func attachChildren() {
        let player = playerBuilder.build(withListener: interactor,
                                         video: "v106400740")
        attachChild(player)
        
        viewController.displayChildren(player: player.viewControllable)
    }
    
}
