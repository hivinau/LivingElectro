//
//  PaddingLabel.swift
//  LivingElectro
//
//  Created by Aude Sautier on 14/05/2017.
//  Copyright © 2017 Hivinau GRAFFE. All rights reserved.
//

import UIKit

public class PaddingLabel: UILabel {
    
    public var topInset = 5.0 as CGFloat {
        
        didSet {
            
            setNeedsDisplay()
        }
    }
    
    public var bottomInset = 5.0 as CGFloat {
        
        didSet {
            
            setNeedsDisplay()
        }
    }
    
    public var leftInset = 7.0 as CGFloat {
        
        didSet {
            
            setNeedsDisplay()
        }
    }
    
    public var rightInset = 7.0 as CGFloat {
        
        didSet {
            
            setNeedsDisplay()
        }
    }
    
    public override var intrinsicContentSize: CGSize {
        
        var intrinsicSuperViewContentSize = super.intrinsicContentSize
        intrinsicSuperViewContentSize.height += topInset + bottomInset
        intrinsicSuperViewContentSize.width += leftInset + rightInset
        
        return intrinsicSuperViewContentSize
    }
    
    public override func drawText(in rect: CGRect) {
        
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
}

