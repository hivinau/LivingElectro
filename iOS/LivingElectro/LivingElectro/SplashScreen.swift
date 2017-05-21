//
//  SplashScreen.swift
//  LivingElectro
//
//  Created by Aude Sautier on 13/05/2017.
//  Copyright © 2017 Hivinau GRAFFE. All rights reserved.
//

import UIKit

@objc(SplashScreen)
public class SplashScreen: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(named: "app_background")
        imageView.contentMode = .scaleAspectFill
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        performSegue(withIdentifier: "home", sender: self)
    }
}
