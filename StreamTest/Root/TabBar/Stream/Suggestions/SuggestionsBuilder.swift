//
//  SuggestionsBuilder.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/25/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import RIBs

protocol SuggestionsDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class SuggestionsComponent: Component<SuggestionsDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol SuggestionsBuildable: Buildable {
    func build(withListener listener: SuggestionsListener) -> SuggestionsRouting
}

final class SuggestionsBuilder: Builder<SuggestionsDependency>, SuggestionsBuildable {

    override init(dependency: SuggestionsDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SuggestionsListener) -> SuggestionsRouting {
        let component = SuggestionsComponent(dependency: dependency)
        let viewController = SuggestionsViewController()
        let interactor = SuggestionsInteractor(presenter: viewController)
        interactor.listener = listener
        return SuggestionsRouter(interactor: interactor, viewController: viewController)
    }
}
