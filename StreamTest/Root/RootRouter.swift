//
//  RootRouter.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/20/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import RIBs

protocol RootInteractable: Interactable, TabBarListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func present(tabBar: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable> {

    //Properties
    let tabBarBuilder: TabBarBuildable
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: RootInteractable,
                  viewController: RootViewControllable,
                  tabBarBuilder: TabBarBuildable) {
        self.tabBarBuilder = tabBarBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}


extension RootRouter: RootRouting {
    
    func routeToTabBar() {
        let tabBar = tabBarBuilder.build(withListener: interactor)
        attachChild(tabBar)
        viewController.present(tabBar: tabBar.viewControllable)
    }
    
}
