//
//  BroadcastBuilder.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/25/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import RIBs

protocol BroadcastDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class BroadcastComponent: Component<BroadcastDependency>, PlayerDependency, ChatDependency {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol BroadcastBuildable: Buildable {
    func build(withListener listener: BroadcastListener) -> BroadcastRouting
}

final class BroadcastBuilder: Builder<BroadcastDependency>, BroadcastBuildable {

    override init(dependency: BroadcastDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: BroadcastListener) -> BroadcastRouting {
        let component = BroadcastComponent(dependency: dependency)
        let viewController = BroadcastViewController()
        let interactor = BroadcastInteractor(presenter: viewController)
        interactor.listener = listener
        
        let playerBuilder = PlayerBuilder(dependency: component)
        let chatBuilder = ChatBuilder(dependency: component)
        
        return BroadcastRouter(interactor: interactor,
                               viewController: viewController,
                               playerBuilder: playerBuilder,
                               chatBuilder: chatBuilder)
    }
}
