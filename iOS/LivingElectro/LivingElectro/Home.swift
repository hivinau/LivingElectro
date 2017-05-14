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
public class Home: UIViewController {
    
    public var parts: [Part]?
    @IBOutlet weak var imageView: UIImageView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(named: "app_background")
        imageView.contentMode = .scaleAspectFill
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
            }
        }
    }
}
