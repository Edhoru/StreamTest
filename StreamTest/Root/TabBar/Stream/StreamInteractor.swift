//
//  StreamInteractor.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/25/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import RIBs
import RxSwift

protocol StreamRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    func routeToBroadcast(_ broadcast: Broadcast)
}

protocol StreamPresentable: Presentable {
    var listener: StreamPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol StreamListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class StreamInteractor: PresentableInteractor<StreamPresentable> {

    weak var router: StreamRouting?
    weak var listener: StreamListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: StreamPresentable) {
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


extension StreamInteractor: StreamInteractable {
    
    func prepareFor(broadcast: Broadcast) {
        router?.routeToBroadcast(broadcast)
    }    
    
}


extension StreamInteractor: StreamPresentableListener {
    
}
