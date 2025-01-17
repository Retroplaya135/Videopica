//
//  Constants.swift
//  Amogh
//
//  Created by Amogh on 13/06/2020.
//  Copyright © 2020 Amogh. All rights reserved.
//

import UIKit

let dataContext = DataManager.sharedInstance.getContext()
let kTitle  = "Playing Style"
let kSingleVideoMessage = "Do you want to play the video in loop?"
let kMultipleVideosMessage = "Do you want to play all the videos in loop?"


class Constants: NSObject {

}

extension Notification.Name {
    static let kAVPlayerViewControllerDismissingNotification = Notification.Name.init("dismissing")
}

