//
//  ChatInteractor.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/28/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import RIBs
import RxSwift

protocol ChatRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    func routeToComments(for stream: Stream)
}

protocol ChatPresentable: Presentable {
    var listener: ChatPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
    func startSearch()
    func display(comments: [Comment])
    func display(error: Error)
}

protocol ChatListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class ChatInteractor: PresentableInteractor<ChatPresentable> {
    
    weak var router: ChatRouting?
    weak var listener: ChatListener?
    
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: ChatPresentable) {
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


extension ChatInteractor: ChatInteractable {
    
    func set(stream: Stream) {
        presenter.startSearch()
        
        CommentsDataService().get { (comments, error) in
            if let commentsError = error {
                self.presenter.display(error: commentsError)
            }
            
            self.presenter.display(comments: comments)
        }
    }
    
}

extension ChatInteractor: ChatPresentableListener {
    
}
