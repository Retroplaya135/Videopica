//
//  Constants.swift
//  VideoPlayer
//
//  Created by Chandra Sekhar Ravi on 22/05/2020.
//  Copyright © 2020 Chandra Sekhar Ravi. All rights reserved.
//

import UIKit

let dataContext = DataManager.sharedInstance.getContext()
let kTitle  = "Playing Style"
let kSingleVideoMessage = "Do you want to play the video in loop?"
let kMultipleVideosMessage = "Do you want to play all the videos in loop?"

let kShowOverlayImage  = "Show Overlay Image"
let kHideOverlayImage  = "Hide Overlay Image"

let kOverlayImage = "OverlayImage"







class Constants: NSObject {

}

extension Notification.Name {
    static let kAVPlayerViewControllerDismissingNotification = Notification.Name.init("dismissing")
}

extension UserDefaults {
    func imageForKey(key: String) -> UIImage? {
        var image: UIImage?
        if let imageData = data(forKey: key) {
            image = NSKeyedUnarchiver.unarchiveObject(with: imageData) as? UIImage
        }
        return image
    }
    func setImage(image: UIImage?, forKey key: String) {
        var imageData: NSData?
        if let image = image {
            imageData = NSKeyedArchiver.archivedData(withRootObject: image) as NSData?
        }
        set(imageData, forKey: key)
    }
}
