//
//  PlayerViewController.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/25/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import AVFoundation

protocol PlayerPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class PlayerViewController: UIViewController {
    
    weak var listener: PlayerPresentableListener?
    
    //Properties
    var broadcast: Broadcast!
    
    //UI
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .cyan
    }
}


extension PlayerViewController: PlayerPresentable {
}

extension PlayerViewController: PlayerViewControllable {
    
    func embed(_ broadcast: Broadcast) {        
        guard let url = broadcast.stream.videoUrl else { return }
        
        let player = AVPlayer(url: url)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
        player.play()
    }
    
}
