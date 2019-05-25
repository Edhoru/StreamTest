//
//  StreamRouter.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/25/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import RIBs

protocol StreamInteractable: Interactable {
    var router: StreamRouting? { get set }
    var listener: StreamListener? { get set }
}

protocol StreamViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class StreamRouter: ViewableRouter<StreamInteractable, StreamViewControllable>, StreamRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: StreamInteractable, viewController: StreamViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
