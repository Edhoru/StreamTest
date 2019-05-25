//
//  StreamBuilder.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/25/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import RIBs

protocol StreamDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class StreamComponent: Component<StreamDependency>, BroadcastDependency, SuggestionsDependency {
    
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol StreamBuildable: Buildable {
    func build(withListener listener: StreamListener) -> StreamRouting
}

final class StreamBuilder: Builder<StreamDependency>, StreamBuildable {
    
    override init(dependency: StreamDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: StreamListener) -> StreamRouting {
        let component = StreamComponent(dependency: dependency)
        let viewController = StreamViewController(icon: #imageLiteral(resourceName: "icon_stream"))
        let interactor = StreamInteractor(presenter: viewController)
        interactor.listener = listener
        
        let broadcastBuilder = BroadcastBuilder(dependency: component)
        let suggestionsBuilder = SuggestionsBuilder(dependency: component)
        
        return StreamRouter(interactor: interactor,
                            viewController: viewController,
                            broadcastBuilder: broadcastBuilder,
                            suggestionsBuilder: suggestionsBuilder)
    }
}
