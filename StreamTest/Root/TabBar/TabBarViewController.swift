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
//        setupControllers()
    }
    
    private func setupUI() {
        view.backgroundColor = .background
        
        tabBar.backgroundColor = .background
        tabBar.isTranslucent = false
        tabBar.barStyle = .blackOpaque
        UITabBar.appearance().tintColor = .green
    }
    
    private func setupControllers() {
        let streamViewController = TabBarChildViewController(icon: #imageLiteral(resourceName: "icon_stream"))
        streamViewController.view.backgroundColor = .red
        
        let searchViewController = TabBarChildViewController(icon: #imageLiteral(resourceName: "icon_search"))
        searchViewController.view.backgroundColor = .green
        
        let notificationsViewController = TabBarChildViewController(icon: #imageLiteral(resourceName: "icon_notifications"))
        notificationsViewController.view.backgroundColor = .blue
        
        let profileViewController = TabBarChildViewController(icon: #imageLiteral(resourceName: "icon_profile"))
        profileViewController.view.backgroundColor = .orange
        
        viewControllers = [streamViewController,
                           searchViewController,
                           notificationsViewController,
                           profileViewController]
        
        
        guard let tabBarChildren = children as? [TabBarChildViewController] else {
            return
        }
        
        let customTabBar = StreamTabBar(children: tabBarChildren)
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


extension TabBarViewController: StreamTabBarDelegate {
    
    func selected(tab: Int) {
        selectedIndex = tab
    }
    
}


extension TabBarViewController: TabBarViewControllable {
    
    func displayChildren(_ children: [TabBarChildViewController]) {
        print(viewControllers)
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
