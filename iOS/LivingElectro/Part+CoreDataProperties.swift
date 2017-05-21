//
//  Part+CoreDataProperties.swift
//  LivingElectro
//
//  Created by iOS Developer on 21/05/2017.
//  Copyright © 2017 Hivinau GRAFFE. All rights reserved.
//

import Foundation
import CoreData


extension Part {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Part> {
        return NSFetchRequest<Part>(entityName: "Part")
    }

    @NSManaged public var genre: String?
    @NSManaged public var songs: NSSet?

}

// MARK: Generated accessors for songs
extension Part {

    @objc(addSongsObject:)
    @NSManaged public func addToSongs(_ value: Song)

    @objc(removeSongsObject:)
    @NSManaged public func removeFromSongs(_ value: Song)

    @objc(addSongs:)
    @NSManaged public func addToSongs(_ values: NSSet)

    @objc(removeSongs:)
    @NSManaged public func removeFromSongs(_ values: NSSet)

}
