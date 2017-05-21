//
//  Song+CoreDataProperties.swift
//  LivingElectro
//
//  Created by iOS Developer on 21/05/2017.
//  Copyright © 2017 Hivinau GRAFFE. All rights reserved.
//

import Foundation
import CoreData


extension Song {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Song> {
        return NSFetchRequest<Song>(entityName: "Song")
    }

    @NSManaged public var artiste: String?
    @NSManaged public var name: String?
    @NSManaged public var stream: String?
    @NSManaged public var published: String?
    @NSManaged public var imageSmall: String?
    @NSManaged public var imageLarge: String?
    @NSManaged public var part: Part?

}
