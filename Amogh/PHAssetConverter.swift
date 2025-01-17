//
//  PHAssetConverter.swift
//  Amogh
//
//  Created by Amogh on 13/06/2020.
//  Copyright © 2020 Amogh. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

class PHAssetConverter: NSObject {
    
   // var videoAssetCallBack : ((AVAsset, UIImage) -> ())?
    
    override init(){
        super.init()
    }

    func getAVAsset(_ asset: PHAsset,  _ callback: @escaping ((AVAsset, UIImage) -> ())){
        
      //  videoAssetCallBack = callback;
        
        let thumbnail = getImageFromasset(asset: asset)
         getVideoAssetFromAsset(asset: asset) { (avAsset) in
            callback(avAsset!,thumbnail)
        }
        
        

    }
    
    
    func getImageFromasset(asset:PHAsset) -> UIImage {
        
            let manager = PHImageManager.default()
            let option = PHImageRequestOptions()
            var thumbnail = UIImage()
            option.isSynchronous = true
            manager.requestImage(for: asset, targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFill, options: option, resultHandler: {(result, info)->Void in
                thumbnail = result!
            })
            return thumbnail
        
    }
    
    func getVideoAssetFromAsset(asset:PHAsset,completion: @escaping (AVAsset?) -> Void) {
        
        PHCachingImageManager().requestAVAsset(forVideo: asset, options: nil) { (videoAsset, audioMix, args) in
            
            completion(videoAsset)

        }
        
    }


    
    
    
    

    
    

}
