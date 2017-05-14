//
//  Song+CoreDataProperties.swift
//  LivingElectro
//
//  Created by Aude Sautier on 14/05/2017.
//  Copyright © 2017 Hivinau GRAFFE. All rights reserved.
//

import Foundation
import CoreData


extension Song {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Song> {
        return NSFetchRequest<Song>(entityName: "Song")
    }

    @NSManaged public var artiste: String?
    @NSManaged public var image: String?
    @NSManaged public var link: String?
    @NSManaged public var song: String?
    @NSManaged public var tag: String?
    @NSManaged public var title: String?
    @NSManaged public var part: Part?

}
