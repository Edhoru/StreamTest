//
//  ChatBuilder.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/28/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import RIBs

protocol ChatDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class ChatComponent: Component<ChatDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol ChatBuildable: Buildable {
    func build(withListener listener: ChatListener) -> ChatRouting
}

final class ChatBuilder: Builder<ChatDependency>, ChatBuildable {

    override init(dependency: ChatDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: ChatListener) -> ChatRouting {
        let component = ChatComponent(dependency: dependency)
        let viewController = ChatViewController()
        let interactor = ChatInteractor(presenter: viewController)
        interactor.listener = listener
        return ChatRouter(interactor: interactor, viewController: viewController)
    }
}
