//
//  AppComponent.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/20/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import RIBs

class AppComponent: Component<EmptyComponent>, RootDependency {
    
    init() {
        super.init(dependency: EmptyComponent())
    }
    
}
