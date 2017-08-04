//
//  UIView~>BlurEffect.swift
//  LivingElectro
//
//  Created by iOS Developer on 05/08/2017.
//  Copyright © 2017 Hivinau GRAFFE. All rights reserved.
//

import UIKit

public extension UIView {
    
    public static func blur(style: UIBlurEffectStyle) -> UIVisualEffectView {
        
        let blurEffect = UIBlurEffect(style: style)
        let effectView = UIVisualEffectView(effect: blurEffect)
        
        return effectView
    }
}

