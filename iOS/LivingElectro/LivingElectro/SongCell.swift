//
//  SongCell.swift
//  LivingElectro
//
//  Created by iOS Developer on 17/05/2017.
//  Copyright © 2017 Hivinau GRAFFE. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

@objc(SongCell)
public class SongCell: UITableViewCell {
    
    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var songLabel: PaddingLabel!
    
    public var songImage: String? {
        didSet {
            
            if let songImage = songImage,
                let url = URL(string: songImage) {
                
                songImageView.af_setImage(withURL: url, placeholderImage: UIImage(named: "placeholder"), imageTransition: .crossDissolve(0.2))
            }
        }
    }
    
    public var songValue: String? {
        didSet {
            
            songLabel.text = songValue
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = .black
        
        songImageView.contentMode = .scaleAspectFill
        songImageView.clipsToBounds = true
        
        songLabel.numberOfLines = 0
        songLabel.lineBreakMode = .byTruncatingTail
        songLabel.textAlignment = .left
        songLabel.textColor = .white
        
        if let font = UIFont(name: "Helvetica", size: 14.0) {
            
            songLabel.font = font
        }
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        songImageView.af_cancelImageRequest()
        songImageView.layer.removeAllAnimations()
        songImageView.image = nil

        songLabel.text?.removeAll()
    }
}
