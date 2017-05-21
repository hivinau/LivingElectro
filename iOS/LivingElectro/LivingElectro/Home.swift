//
//  Home.swift
//  LivingElectro
//
//  Created by Aude Sautier on 13/05/2017.
//  Copyright © 2017 Hivinau GRAFFE. All rights reserved.
//

import UIKit

@objc(Home)
public class Home: UIViewController, TitlesDelegate, PartsDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    private var titles: Titles?
    private var parts: Parts?
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    }
    
    public func titles(_ titles: Titles, didSelectRowAt indexPath: IndexPath) {
        
        parts?.selectRow(at: indexPath)
    }
    
    public func parts(_ parts: Parts, didSelectRowAt indexPath: IndexPath) {
        
        titles?.selectRow(at: indexPath)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(named: "app_background")
        imageView.contentMode = .scaleAspectFill

        titles?.titlesDelegate = self
        parts?.partsDelegate = self
        
        if let genres = LocalizableHelper.value(for: "genres") as? [String] {
            
            titles?.genres = genres
            
            genres.forEach {
                genre in
                
                parts?.addSongs(for: genre)
            }
        }
        
        let indexPath = IndexPath(row: 0, section: 0)
        
        titles?.selectRow(at: indexPath)
        parts?.selectRow(at: indexPath)
    }
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let titles = segue.destination as? Titles {
            
            self.titles = titles
            
        } else if let parts = segue.destination as? Parts {
            
            self.parts = parts
        }
    }
}
