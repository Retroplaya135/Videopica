//
//  SingleVideoLooped.swift
//  Amogh
//
//  Created by Amogh on 13/06/2020.
//  Copyright © 2020 Amogh. All rights reserved.
//

import UIKit
import AVKit

class SingleVideoLooper: NSObject,BackgroundLooper {
    
    
    private var player: AVPlayer?
    private var playerController: AVPlayerViewController?
    private let asset :AVAsset
    private var playerItem :AVPlayerItem?
    
    
    
    
    required init(asset:AVAsset) {
        self.asset = asset
    }
    
    func start(in viewController: UIViewController, andloop loop:Bool) {
        playerItem = AVPlayerItem(asset: self.asset)
        player = AVPlayer(playerItem: self.playerItem)
        playerController = AVPlayerViewController()
        playerController?.player = player
        player?.actionAtItemEnd = .none
        loopVideo(videoPlayer: player!, onlyLoop: loop)
        viewController.present(playerController!, animated: true) {
            self.player?.play()
        }
    }
    
    func loopVideo(videoPlayer: AVPlayer, onlyLoop:Bool) {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) { notification in
            if onlyLoop == true{
                videoPlayer.seek(to: CMTime.zero)
                videoPlayer.play()
            }else{
                self.playerController!.dismiss(animated: true, completion: {
                    NotificationCenter.default.removeObserver(self)
                })
            }
        }
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
    
}



protocol BackgroundLooper {
    /// Loops the videos specified forever.
    init (asset:AVAsset)
    
    //Start Playback
    func start(in viewController: UIViewController, andloop loop:Bool)
}
