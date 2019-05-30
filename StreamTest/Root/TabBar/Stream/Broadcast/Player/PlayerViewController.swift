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
import WebKit

protocol PlayerPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class PlayerViewController: UIViewController {
    
    weak var listener: PlayerPresentableListener?
    
    //Properties
    var broadcast: Broadcast!
    var playerLayer: AVPlayerLayer!
    
    //UI
    var webView: WKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .cyan
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if playerLayer != nil {
            playerLayer.frame = self.view.bounds
        }
    }
}


extension PlayerViewController: PlayerPresentable {
}


extension PlayerViewController: PlayerViewControllable {
    
    func embed(_ broadcast: Broadcast) {
        guard let url = broadcast.stream.videoUrl else { return }
        
        webView = nil
        
        view.subviews.forEach { (subview) in
            subview.removeFromSuperview()
        }        
        
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.allowsInlineMediaPlayback = true
        
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        
        guard let validWebView = webView else { return }
        validWebView.allowsLinkPreview = true
        
        validWebView.frame = view.bounds
        view.addSubview(validWebView)
        
        let myRequest = URLRequest(url: url)
        validWebView.load(myRequest)
        return
        
        //The backup plan
        //        guard let url = broadcast.stream.staticVideoUrl else { return }
        //        let player = AVPlayer(url: url)
        //        playerLayer = AVPlayerLayer(player: player)
        //        playerLayer.frame = self.view.bounds
        //        playerLayer.videoGravity = .resizeAspect
        //        playerLayer.needsDisplayOnBoundsChange = true
        //
        //        player.isMuted = true
        //
        //        self.view.layer.addSublayer(playerLayer)
        //        player.play()
    }
    
}
