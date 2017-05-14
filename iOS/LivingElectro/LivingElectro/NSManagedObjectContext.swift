//
//  NSManagedObjectContext.swift
//  LivingElectro
//
//  Created by Aude Sautier on 14/05/2017.
//  Copyright © 2017 Hivinau GRAFFE. All rights reserved.
//

import CoreData
import UIKit

public extension NSManagedObjectContext {
    
    public static func create(entity: String) -> NSManagedObject? {
        
        guard let application = UIApplication.shared.delegate as? AppDelegate else {
                
                return nil
        }
        
        let context = application.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: entity, in: context) else {
            
            return nil
        }
        
        return NSManagedObject(entity: entity, insertInto: context)
    }
    
    public static func commit() -> Bool {
        
        guard let application = UIApplication.shared.delegate as? AppDelegate else {
            
            return false
        }
        
        let context = application.persistentContainer.viewContext
        
        if context.hasChanges {
            
            do {
                
                try context.save()
            } catch {
                
                return false
            }
        }
        
        return true
    }
    
    public static func entities(of name: String, where predicate: NSPredicate?) -> [NSFetchRequestResult]? {
        
        guard let application = UIApplication.shared.delegate as? AppDelegate else {
            
            return nil
        }
        
        let context = application.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSManagedObject>(entityName: name)
        request.predicate = predicate
        
        do {
            
            return try context.fetch(request)
            
        } catch  {}
        
        return nil
    }
    
    public static func clear(entity: String, where predicate: NSPredicate?) -> Bool {
        
        guard let application = UIApplication.shared.delegate as? AppDelegate else {
            
            return false
        }
        
        let context = application.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSManagedObject>(entityName: entity)
        request.predicate = predicate
        
        do {
            
            let results = try context.fetch(request)
            
            results.forEach({
                result in
                
                context.delete(result)
            })
            
            try context.save()
            
        } catch  {
            
            return false
        }
        
        return true
    }
}

