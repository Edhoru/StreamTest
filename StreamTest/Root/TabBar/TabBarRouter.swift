//
//  TabBarRouter.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/21/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import RIBs

protocol TabBarInteractable: Interactable {
    var router: TabBarRouting? { get set }
    var listener: TabBarListener? { get set }
}

protocol TabBarViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class TabBarRouter: ViewableRouter<TabBarInteractable, TabBarViewControllable>, TabBarRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: TabBarInteractable, viewController: TabBarViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
