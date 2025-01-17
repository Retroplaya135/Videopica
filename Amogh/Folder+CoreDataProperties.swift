//
//  Folder+CoreDataProperties.swift
//  Amogh
//
//  Created by Chandra Sekhar Ravi on 13/06/2020.
//  Copyright © 2020 Chandra Sekhar Ravi. All rights reserved.
//
//

import Foundation
import CoreData


extension Folder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Folder> {
        return NSFetchRequest<Folder>(entityName: "Folder")
    }

    @NSManaged public var folderName: String?
    @NSManaged public var totalVideos: Int16
    @NSManaged public var videos: [String]?

}
