//
//  PlayerBuilder.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/25/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import RIBs

protocol PlayerDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class PlayerComponent: Component<PlayerDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol PlayerBuildable: Buildable {
    func build(withListener listener: PlayerListener,
               video: String) -> PlayerRouting
}

final class PlayerBuilder: Builder<PlayerDependency>, PlayerBuildable {

    override init(dependency: PlayerDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: PlayerListener,
               video: String) -> PlayerRouting {
        let component = PlayerComponent(dependency: dependency)
        let viewController = PlayerViewController()
        let interactor = PlayerInteractor(presenter: viewController, video: video)
        interactor.listener = listener
        return PlayerRouter(interactor: interactor, viewController: viewController)
    }
}
