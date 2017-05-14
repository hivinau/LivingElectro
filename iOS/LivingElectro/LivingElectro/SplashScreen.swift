//
//  SplashScreen.swift
//  LivingElectro
//
//  Created by Aude Sautier on 13/05/2017.
//  Copyright © 2017 Hivinau GRAFFE. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

@objc(SplashScreen)
public class SplashScreen: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    private var parts: [Part]?
    private var lastRequest: DataRequest?
    private lazy var url: String? = {
        
        if let host = ApiHelper.value(for: "host") as? String,
            let route = ApiHelper.value(for: "home") as? String {
            
            return String(format: "%@%@", host, route)
        }
        
        return nil
    }()

    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(named: "app_background")
        imageView.contentMode = .scaleAspectFill
        
        retrieveResults(of: url, completion: {
            [unowned self] parts in
            
            if let parts = parts {
                
                self.parts = parts
                self.performSegue(withIdentifier: "home", sender: self)
            }
        })
    }
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "home" {
            
            if let navigationController = segue.destination as? UINavigationController,
                let controller = navigationController.childViewControllers.first as? Home {
                
                controller.parts = parts
            }
        }
    }
    
    private func retrieveResults(of url: String?, completion: @escaping ([Part]?) -> Void) {
        
        if let url = url {
            
            lastRequest?.cancel()
            
            lastRequest = Alamofire.request(url).responseJSON {
                response in
                
                if let array = response.result.value as? [[String: Any]] {
                    
                    var parts = [Part]()
                    
                    array.forEach({
                        item in
                        
                        if let title = item.keys.first {
                            
                            if let part = NSManagedObjectContext.create(entity: "Part") as? Part {
                                
                                part.setValue(title, forKeyPath: "title")
                                
                                if let subArray = item[title] as? [[String: Any]] {
                                    
                                    subArray.forEach({
                                        subItem in
                                        
                                        if let artiste = subItem["artiste"] as? String,
                                            let image = subItem["image"] as? String,
                                            let link = subItem["link"] as? String,
                                            let song = subItem["song"] as? String,
                                            let tag = subItem["tag"] as? String,
                                            let title = subItem["title"] as? String {
                                            
                                            if let songObject = NSManagedObjectContext.create(entity: "Song") as? Song {
                                                
                                                songObject.setValue(artiste, forKeyPath: "artiste")
                                                songObject.setValue(image, forKeyPath: "image")
                                                songObject.setValue(link, forKeyPath: "link")
                                                songObject.setValue(song, forKeyPath: "song")
                                                songObject.setValue(tag, forKeyPath: "tag")
                                                songObject.setValue(title, forKeyPath: "title")
                                                
                                                part.addToSongs(songObject)
                                            }
                                        }
                                    })
                                }
                                
                                parts.append(part)
                            }
                        }
                    })
                    
                    completion(parts)
                } else {
                    
                    completion(nil)
                }
            }
        }
    }
}
