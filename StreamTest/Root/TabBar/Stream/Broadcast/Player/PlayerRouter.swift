//
//  PlayerRouter.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/25/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import RIBs

protocol PlayerInteractable: Interactable {
    var router: PlayerRouting? { get set }
    var listener: PlayerListener? { get set }
}

protocol PlayerViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class PlayerRouter: ViewableRouter<PlayerInteractable, PlayerViewControllable>, PlayerRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: PlayerInteractable, viewController: PlayerViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
