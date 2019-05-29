//
//  ChatRouter.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/28/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import RIBs

protocol ChatInteractable: Interactable {
    var router: ChatRouting? { get set }
    var listener: ChatListener? { get set }
    
    func set(stream: Stream)
}

protocol ChatViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func set(stream: Stream)
}

final class ChatRouter: ViewableRouter<ChatInteractable, ChatViewControllable> {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: ChatInteractable, viewController: ChatViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}


extension ChatRouter: ChatRouting {
    
    func routeToComments(for stream: Stream) {
        interactor.set(stream: stream)
    }

}
