//
//  MultipleVideoLooper.swift
//  TestingVideo
//
//  Created by Chandra Sekhar Ravi on 29/05/2020.
//  Copyright © 2020 Chandra Sekhar Ravi. All rights reserved.
//

import UIKit
import AVKit

class MultipleVideoLooper: NSObject, MultipleVideoLooperProtocol {
    
    private var player =  AVQueuePlayer()
    private var playerController = AVPlayerViewController()
    private let clips : [AVAsset]
    let videoComposition = AVMutableComposition()
    var playerItem: AVPlayerItem!
    var lastTime: CMTime = CMTime.zero
    var loopAllVideos:Bool?
    
    private var token: NSKeyValueObservation?
    
    
    required init(assetItems:[AVAsset]) {
        self.clips = assetItems
    }
    
    func start(in viewController: UIViewController, and loop:Bool) {
        
      //  self.loopAllVideos = loop
        self.addAllVideosToPlayer()
        viewController.present(playerController, animated: true, completion: { self.player.play() })
        
        
    
    }
    
    
    func addAllVideosToPlayer() {
        playerController.player = player

        for clip in clips {
            let playerItem = AVPlayerItem(asset: clip)
            player.insert(playerItem, after: player.items().last)
            token = player.observe(\.currentItem) { player, _ in
                if player.items().count == 1
                {
                    self.addAllVideosToPlayer()
                }
        }
            
        }
    }

    
    
    
//    func loopVideo(videoPlayer: AVPlayer, onlyLoop:Bool) {
//               NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) { notification in
//                   if onlyLoop == true{
//                       videoPlayer.seek(to: CMTime.zero)
//                       videoPlayer.play()
//                   }else{
//                       self.playerController!.dismiss(animated: true, completion: {
//                           NotificationCenter.default.removeObserver(self)
//                       })
//                   }
//               }
//           }
    
    
    
    //   func start(in viewController: UIViewController, and loop:Bool) {
    
    
    
    //        let composition = AVMutableComposition()
    //        let compositionVideoTrack = composition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)
    //        let compositionAudioTrack = composition.addMutableTrack(withMediaType: .audio, preferredTrackID: kCMPersistentTrackID_Invalid)
    //
    //        var insertTime = CMTime.zero
    //        for asset in clips{
    //            let range = CMTimeRange(start: .zero, duration: asset.duration)
    //            guard let videoTrack = asset.tracks(withMediaType: .video).first,
    //                let audioTrack = asset.tracks(withMediaType: .audio).first else {
    //                    continue
    //            }
    //
    //          //  compositionVideoTrack?.preferredTransform = orientation!
    //            try? compositionVideoTrack?.insertTimeRange(range, of: videoTrack, at: insertTime)
    //            try? compositionAudioTrack?.insertTimeRange(range, of: audioTrack, at: insertTime)
    //
    //            insertTime = CMTimeAdd(insertTime, asset.duration)
    //        }
    //
    //
    //        playerItem = AVPlayerItem(asset:composition)
    //        player = AVPlayer(playerItem: playerItem)
    //        playerController = AVPlayerViewController()
    //        playerController?.player = player
    //        player?.actionAtItemEnd = .none
    //        player?.allowsExternalPlayback = false
    //        player?.usesExternalPlaybackWhileExternalScreenIsActive = false
    //        loopVideo(videoPlayer: player!, onlyLoop: loop)
    //        viewController.present(playerController!, animated: true) {
    //            self.player?.play()
    //        }
    
    
    //    }
    
    //    func loopVideo(videoPlayer: AVPlayer, onlyLoop:Bool) {
    //        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) { notification in
    //            if onlyLoop == true{
    //                videoPlayer.seek(to: CMTime.zero)
    //                videoPlayer.play()
    //            }else{
    //                self.playerController!.dismiss(animated: true, completion: {
    //                    NotificationCenter.default.removeObserver(self)
    //                })
    //            }
    //        }
    //    }
    
    
    //
    //    func stop() {
    //        player?.pause()
    //    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
}

protocol MultipleVideoLooperProtocol {
    /// Loops the videos specified forever.
    init (assetItems:[AVAsset])
    
    //Start Playback
    func start(in viewController: UIViewController, and loop:Bool)
}
