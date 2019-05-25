//
//  BroadcastRouter.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/25/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import RIBs

protocol BroadcastInteractable: Interactable {
    var router: BroadcastRouting? { get set }
    var listener: BroadcastListener? { get set }
}

protocol BroadcastViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class BroadcastRouter: ViewableRouter<BroadcastInteractable, BroadcastViewControllable>, BroadcastRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: BroadcastInteractable, viewController: BroadcastViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
