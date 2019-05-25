//
//  SuggestionsRouter.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/25/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import RIBs

protocol SuggestionsInteractable: Interactable {
    var router: SuggestionsRouting? { get set }
    var listener: SuggestionsListener? { get set }
}

protocol SuggestionsViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class SuggestionsRouter: ViewableRouter<SuggestionsInteractable, SuggestionsViewControllable>, SuggestionsRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: SuggestionsInteractable, viewController: SuggestionsViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
