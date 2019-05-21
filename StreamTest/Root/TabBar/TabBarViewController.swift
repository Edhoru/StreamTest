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

final class TabBarViewController: UITabBarController, TabBarPresentable, TabBarViewControllable {
    
    weak var listener: TabBarPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupControllers()
    }
    
    private func setupUI() {
        view.backgroundColor = .yellow
    }
    
    private func setupControllers() {
        let streamViewController = UIViewController()
        streamViewController.view.backgroundColor = .red
        
        let searchViewController = UIViewController()
        searchViewController.view.backgroundColor = .green
        
        let notificationsViewController = UIViewController()
        notificationsViewController.view.backgroundColor = .blue
        let notificationsItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 2)
        notificationsViewController.tabBarItem = notificationsItem
        
        let profileViewController = UIViewController()
        profileViewController.view.backgroundColor = .orange
        
        viewControllers = [streamViewController,
                           searchViewController,
                           notificationsViewController,
                           profileViewController]
        
        tabBar.backgroundColor = .background
        
        
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .background
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 10, y: 10, width: 50, height: 150)
        button.backgroundColor = .green
        
        
        self.tabBar.addSubview(view)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: tabBar.topAnchor),
            view.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor),
            ])
    }
    
    
}

