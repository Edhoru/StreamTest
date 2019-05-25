//
//  TabBarRouter.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/21/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import RIBs

protocol TabBarInteractable: Interactable, StreamListener {
    var router: TabBarRouting? { get set }
    var listener: TabBarListener? { get set }
}

protocol TabBarViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func displayChildren(_ children: [TabBarChildViewController])
}

final class TabBarRouter: ViewableRouter<TabBarInteractable, TabBarViewControllable>, TabBarRouting {
    
    private var currentChild: ViewableRouting?
    
    let streamBuilder: StreamBuildable
    let searchBuilder: StreamBuildable?
    let notificationsBuilder: StreamBuildable?
    let profileBuilder: StreamBuildable?
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: TabBarInteractable,
         viewController: TabBarViewControllable,
         streamBuilder: StreamBuildable,
         searchBuilder: StreamBuildable?,
         notificationsBuilder: StreamBuildable?,
         profileBuilder: StreamBuildable?) {
        
        self.streamBuilder = streamBuilder
        self.searchBuilder = searchBuilder
        self.notificationsBuilder = notificationsBuilder
        self.profileBuilder = profileBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
        
        buildChildren()
    }
    
    private func buildChildren() {
        let stream = streamBuilder.build(withListener: interactor)
        attachChild(stream)
        
        let searchViewController = TabBarChildViewController(icon: #imageLiteral(resourceName: "icon_search"))
        searchViewController.view.backgroundColor = .green
        
        let notificationsViewController = TabBarChildViewController(icon: #imageLiteral(resourceName: "icon_notifications"))
        notificationsViewController.view.backgroundColor = .blue
        
        let profileViewController = TabBarChildViewController(icon: #imageLiteral(resourceName: "icon_profile"))
        profileViewController.view.backgroundColor = .orange
        
        guard let streamViewController = stream.viewControllable as? TabBarChildViewController/*,
             let searchViewController = search.viewControllable as? TabBarChildViewController,
             let notificationsViewController = notifications.viewControllable as? TabBarChildViewController,
             let profileViewController = profile.viewControllable as? TabBarChildViewController */ else {
                fatalError("Children don't have the correct class")
        }
        
        viewController.displayChildren([streamViewController,
                                        searchViewController,
                                        notificationsViewController,
                                        profileViewController])
    }
    
}
