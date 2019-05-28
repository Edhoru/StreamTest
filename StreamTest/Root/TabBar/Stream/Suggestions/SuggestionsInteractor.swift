//
//  SuggestionsInteractor.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/25/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import RIBs
import RxSwift

protocol SuggestionsRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SuggestionsPresentable: Presentable {
    var listener: SuggestionsPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
    func display(broadcasts: [Broadcast])
}

protocol SuggestionsListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func prepareFor(broadcast: Broadcast)
}

final class SuggestionsInteractor: PresentableInteractor<SuggestionsPresentable> {

    weak var router: SuggestionsRouting?
    weak var listener: SuggestionsListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: SuggestionsPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
        BroadcastsDataService().get { (broadcasts, error) in
            guard error == nil else {
                fatalError("there is an error when getting the suggestions")
            }
            
            self.presenter.display(broadcasts: broadcasts)
        }
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}


extension SuggestionsInteractor: SuggestionsInteractable {
    
}

extension SuggestionsInteractor: SuggestionsPresentableListener {
    
    func select(broadcast: Broadcast) {
        listener?.prepareFor(broadcast: broadcast)
    }
    
}
