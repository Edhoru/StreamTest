//
//  RootViewController.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/20/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol RootPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class RootViewController: UIViewController, RootPresentable {

    weak var listener: RootPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}


extension RootViewController: RootViewControllable {
    
    func present(tabBar: ViewControllable) {
        present(tabBar.uiviewController, animated: true)
    }
    
}
