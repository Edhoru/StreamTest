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
        
        attachChildren()
    }
    
    private func attachChildren() {
        let stream = streamBuilder.build(withListener: interactor)
        attachChild(stream)
        
        guard let streamViewController = stream.viewControllable as? TabBarChildViewController/*,
             let searchViewController = search.viewControllable as? TabBarChildViewController,
             let notificationsViewController = notifications.viewControllable as? TabBarChildViewController,
             let profileViewController = profile.viewControllable as? TabBarChildViewController */
            else {
                fatalError("Children don't have the correct class")
        }
        
        //This childs don't have implementation, so for now we are only going to show empty view
        let searchViewController = SearchViewController(icon: #imageLiteral(resourceName: "icon_search"))
        let notificationsViewController = NotificationsViewController(icon: #imageLiteral(resourceName: "icon_notifications"))
        let profileViewController = ProfileViewController(icon: #imageLiteral(resourceName: "icon_profile"))
        
        let allChildren = [streamViewController,
                           searchViewController,
                           notificationsViewController,
                           profileViewController]
        
        viewController.displayChildren(allChildren)
    }
    
}
