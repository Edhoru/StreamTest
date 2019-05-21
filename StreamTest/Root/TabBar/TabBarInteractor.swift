//
//  TabBarInteractor.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/21/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import RIBs
import RxSwift

protocol TabBarRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol TabBarPresentable: Presentable {
    var listener: TabBarPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol TabBarListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class TabBarInteractor: PresentableInteractor<TabBarPresentable>, TabBarInteractable, TabBarPresentableListener {

    weak var router: TabBarRouting?
    weak var listener: TabBarListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: TabBarPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
