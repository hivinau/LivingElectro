//
//  LocalizableHelper.swift
//  LivingElectro
//
//  Created by iOS Developer on 21/05/2017.
//  Copyright © 2017 Hivinau GRAFFE. All rights reserved.
//

import UIKit

public class LocalizableHelper {
    
    public static func value(for key: String) -> Any? {
        
        var value: Any? = nil
        
        if let localizable = PropertyListSerialization.localizable() {
            
            value = localizable[key]
        }
        
        return value
    }
}
