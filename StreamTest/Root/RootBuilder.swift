//
//  RootBuilder.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/20/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import RIBs

protocol RootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class RootComponent: Component<RootDependency>, TabBarDependency {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    func build() -> LaunchRouting {
        let component = RootComponent(dependency: dependency)
        let viewController = RootViewController()
        let interactor = RootInteractor(presenter: viewController)
        
        let tabBarBuilder = TabBarBuilder(dependency: component)
        
        return RootRouter(interactor: interactor,
                          viewController: viewController,
                          tabBarBuilder: tabBarBuilder)
    }
}
