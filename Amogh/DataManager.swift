//
//  DataManager.swift
//  VideoPlayer
//
//  Created by Chandra Sekhar Ravi on 22/05/2020.
//  Copyright © 2020 Chandra Sekhar Ravi. All rights reserved.
//

import UIKit
import CoreData

class DataManager: NSObject {
    
    public static let sharedInstance = DataManager()
    private override init() {}
    
    // Helper func for getting the current context.
    func getContext() -> NSManagedObjectContext? {
           guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
           return appDelegate.persistentContainer.viewContext
       }


}
