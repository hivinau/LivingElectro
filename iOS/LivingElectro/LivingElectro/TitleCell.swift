//
//  TitleCell.swift
//  LivingElectro
//
//  Created by Aude Sautier on 14/05/2017.
//  Copyright © 2017 Hivinau GRAFFE. All rights reserved.
//

import UIKit

@objc(TitleCell)
public class TitleCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: PaddingLabel!
    
    public var titleValue: String? {
        didSet {
            
            titleLabel.text = titleValue
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        
        if let font = UIFont(name: "Helvetica", size: 14.0) {
            
            titleLabel.font = font
        }
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text?.removeAll()
    }

}
