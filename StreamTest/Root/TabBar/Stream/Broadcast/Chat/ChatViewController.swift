//
//  ChatViewController.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/28/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol ChatPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class ChatViewController: UIViewController, ChatPresentable, ChatViewControllable {

    weak var listener: ChatPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
    }
}
