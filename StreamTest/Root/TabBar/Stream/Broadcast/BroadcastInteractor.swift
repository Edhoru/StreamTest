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
        NotificationCenter.default.addObserver(self, selector: #selector(likeLogic(_:)), name: .videoLiked, object: nil)
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func likeLogic(_ notification: Notification) {
        guard let streamer = notification.object as? Streamer else { return }
        
        //Reduce the number of available likes
        UserDefaults.standard.likesToGive -= 1
        
        //Store the number of extra likes given to a streamer
        var likesGiven = UserDefaults.standard.likesGiven
        likesGiven[streamer.id] = (likesGiven[streamer.id] ?? 0) + 1
        UserDefaults.standard.likesGiven = likesGiven
        
        presenter.updateLikeCount()
    }
}
