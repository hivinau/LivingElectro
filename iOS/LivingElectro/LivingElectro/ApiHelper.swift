//
//  ApiHelper.swift
//  LivingElectro
//
//  Created by Aude Sautier on 13/05/2017.
//  Copyright © 2017 Hivinau GRAFFE. All rights reserved.
//

import UIKit

public class ApiHelper {
    
    public static func value(for key: String) -> Any? {
        
        var value: Any? = nil
        
        if let api = PropertyListSerialization.api() {
            
            value = api[key]
        }
        
        return value
    }
}


