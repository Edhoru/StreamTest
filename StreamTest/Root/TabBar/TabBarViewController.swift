//
//  TabBarViewController.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/21/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol TabBarPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class TabBarViewController: UITabBarController, TabBarPresentable {
    
    weak var listener: TabBarPresentableListener?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .background
        
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
    }
    
}


extension TabBarViewController: StreamTabBarDelegate {
    
    func selected(tab: Int) {
        selectedIndex = tab
    }
    
}


extension TabBarViewController: TabBarViewControllable {
    
    func displayChildren(_ children: [TabBarChildViewController]) {
        self.viewControllers = children
        
        let customTabBar = StreamTabBar(children: children)
        customTabBar.delegate = self
        view.addSubview(customTabBar)
        
        NSLayoutConstraint.activate([
            customTabBar.topAnchor.constraint(equalTo: tabBar.topAnchor),
            customTabBar.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
            customTabBar.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
            customTabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
    }
    
}
