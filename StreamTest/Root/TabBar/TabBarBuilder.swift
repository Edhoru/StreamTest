//
//  TabBarBuilder.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/21/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import RIBs

protocol TabBarDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class TabBarComponent: Component<TabBarDependency>, StreamDependency {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol TabBarBuildable: Buildable {
    func build(withListener listener: TabBarListener) -> TabBarRouting
}

final class TabBarBuilder: Builder<TabBarDependency>, TabBarBuildable {
    
    

    override init(dependency: TabBarDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: TabBarListener) -> TabBarRouting {
        let component = TabBarComponent(dependency: dependency)
        let viewController = TabBarViewController()
        let interactor = TabBarInteractor(presenter: viewController)
        interactor.listener = listener
        
        let streamBuilder = StreamBuilder(dependency: component)
//        let searchBuilder = SearchBuilder(dependency: component)
//        let notificationsBuilder = NotificationsBuilder(dependency: component)
//        let profileBuilder = ProfileBuilder(dependency: component)
        
        return TabBarRouter(interactor: interactor,
                            viewController: viewController,
                            streamBuilder: streamBuilder,
                            searchBuilder: nil,
                            notificationsBuilder: nil,
                            profileBuilder: nil)
    }
}
