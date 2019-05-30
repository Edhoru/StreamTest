//
//  TabBarChildViewController.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/22/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import UIKit

class TabBarChildViewController: UIViewController {

    //UI
    var icon: UIImage = #imageLiteral(resourceName: "icon_stream.png")
    var emptyView: EmptyView?
    
    init(icon: UIImage) {
        super.init(nibName: nil, bundle: nil)
        
        self.icon = icon
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emptyView?.animation(play: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        emptyView?.animation(play: false)
    }
    
    func addEmptyView(kind: EmptyView.Kind) {
        let emptyView = EmptyView(kind: kind)
        view.addSubview(emptyView)
        
        NSLayoutConstraint.activate([
            emptyView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            emptyView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            emptyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        
        self.emptyView = emptyView
    }

}
