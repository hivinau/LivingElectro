//
//  SongCell.swift
//  LivingElectro
//
//  Created by iOS Developer on 17/05/2017.
//  Copyright © 2017 Hivinau GRAFFE. All rights reserved.
//

import UIKit

@objc(SongCell)
public class SongCell: UITableViewCell {
    
    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var songLabel: PaddingLabel!
    
    public var songImage: UIImage? {
        didSet {
            
            songImageView.image = songImage
        }
    }
    
    public var songValue: String? {
        didSet {
            
            songLabel.text = songValue
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        songImageView.contentMode = .scaleAspectFill
        songImageView.clipsToBounds = true
        
        songLabel.numberOfLines = 0
        songLabel.lineBreakMode = .byTruncatingTail
        songLabel.textAlignment = .left
        songLabel.textColor = .black
        
        if let font = UIFont(name: "Helvetica", size: 14.0) {
            
            songLabel.font = font
        }
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        songImageView.image = nil
        songLabel.text?.removeAll()
    }
}
