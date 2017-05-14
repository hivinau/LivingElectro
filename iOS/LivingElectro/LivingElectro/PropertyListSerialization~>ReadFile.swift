//
//  PropertyListSerialization~>ReadFile.swift
//  LivingElectro
//
//  Created by Aude Sautier on 13/05/2017.
//  Copyright © 2017 Hivinau GRAFFE. All rights reserved.
//

import UIKit

public extension PropertyListSerialization {
    
    public static func api() -> Dictionary<String,Any>? {
        
        return PropertyListSerialization.read(of: "api")
    }
    
    private static func read(of api: String) -> Dictionary<String,Any>? {
        
        var content: Dictionary<String,Any>? = nil
        
        if let c = PropertyListSerialization.content(of: api) as? Dictionary<String,Any> {
            
            content = c
        }
        
        return content
    }
    
    private static func content(of file: String) -> Any? {
        
        var content: Any? = nil
        
        if let path = Bundle.main.path(forResource: file, ofType: "plist") {
            
            let url = URL(fileURLWithPath: path)
            
            do {
                
                let data = try Data(contentsOf: url)
                
                content = try PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil)
                
            } catch {
                
            }
        }
        
        return content
    }
}


