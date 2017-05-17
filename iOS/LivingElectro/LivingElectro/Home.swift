//
//  Home.swift
//  LivingElectro
//
//  Created by Aude Sautier on 13/05/2017.
//  Copyright © 2017 Hivinau GRAFFE. All rights reserved.
//

import UIKit
import CoreData

@objc(Home)
public class Home: UIViewController, TitlesDelegate, PartsDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    private var titlesController: Titles?
    private var partsController: Parts?
    public var parts: [Part]?
    
    public func titles(_ titles: Titles, didSelectRowAt indexPath: IndexPath) {
        
        partsController?.selectRow(at: indexPath)
    }
    
    public func parts(_ parts: Parts, didSelectRowAt indexPath: IndexPath) {
        
        titlesController?.selectRow(at: indexPath)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(named: "app_background")
        imageView.contentMode = .scaleAspectFill
        
        titlesController?.titlesDelegate = self
        partsController?.partsDelegate = self
    }
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let parts = parts {
            
            if let controller = segue.destination as? Titles {
                
                let titles = parts.map({
                    part in
                    
                    return part.title
                })
                
                controller.titles = titles
                titlesController = controller
            }
            
            if let controller = segue.destination as? Parts {
                
                parts.forEach({
                    part in

                    controller.addPart(part)
                })
                
                partsController = controller
            }
        }
    }
}
