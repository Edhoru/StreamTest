//
//  StreamRouter.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/25/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import RIBs

protocol StreamInteractable: Interactable, BroadcastListener, SuggestionsListener {
    var router: StreamRouting? { get set }
    var listener: StreamListener? { get set }
}

protocol StreamViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func displayChildren(_ suggestions: ViewControllable,
                         broadcast: ViewControllable)
}

final class StreamRouter: ViewableRouter<StreamInteractable, StreamViewControllable>, StreamRouting {
    
    let broadcastBuilder: BroadcastBuildable
    let suggestionsBuilder: SuggestionsBuildable
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: StreamInteractable,
         viewController: StreamViewControllable,
         broadcastBuilder: BroadcastBuildable,
         suggestionsBuilder: SuggestionsBuildable) {
        self.broadcastBuilder = broadcastBuilder
        self.suggestionsBuilder = suggestionsBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
        
        attachChildren()
    }
    
    private func attachChildren() {
        let broadcast = broadcastBuilder.build(withListener: interactor)
        attachChild(broadcast)
        
        let suggestions = suggestionsBuilder.build(withListener: interactor)
        attachChild(suggestions)
        
        viewController.displayChildren(suggestions.viewControllable,
                                       broadcast: broadcast.viewControllable)
    }
    
}
