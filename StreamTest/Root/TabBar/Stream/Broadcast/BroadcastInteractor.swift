//
//  BroadcastInteractor.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/25/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import RIBs
import RxSwift

protocol BroadcastRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    func set(broadcast: Broadcast)
}

protocol BroadcastPresentable: Presentable {
    var listener: BroadcastPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
    func updateLikeCount()
}

protocol BroadcastListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class BroadcastInteractor: PresentableInteractor<BroadcastPresentable>, BroadcastInteractable, BroadcastPresentableListener {

    weak var router: BroadcastRouting?
    weak var listener: BroadcastListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: BroadcastPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
        NotificationCenter.default.addObserver(self, selector: #selector(likeLogic), name: .videoLiked, object: nil)
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func likeLogic() {
        UserDefaults.standard.likesToGive -= 1
        presenter.updateLikeCount()
    }
}
