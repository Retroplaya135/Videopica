//
//  DataManager.swift
//  Amogh
//
//  Created by Amogh on 13/06/2020.
//  Copyright © 2020 Amogh. All rights reserved.
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
