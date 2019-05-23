//
//  TabBarChildViewController.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/22/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import UIKit

class TabBarChildViewController: UIViewController {

    var icon: UIImage = #imageLiteral(resourceName: "icon_stream.png")
    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
