//
//  PlayerInteractor.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/25/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import RIBs
import RxSwift

protocol PlayerRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol PlayerPresentable: Presentable {
    var listener: PlayerPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol PlayerListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class PlayerInteractor: PresentableInteractor<PlayerPresentable>, PlayerInteractable, PlayerPresentableListener {

    weak var router: PlayerRouting?
    weak var listener: PlayerListener?
    
    var video: String

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: PlayerPresentable, video: String) {
        self.video = video
        
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
