//
//  Part~>Load.swift
//  LivingElectro
//
//  Created by iOS Developer on 21/05/2017.
//  Copyright © 2017 Hivinau GRAFFE. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

public extension Part {
    
    public static func load(from url: String?, completion: @escaping (Part?) -> Void) {
        
        if let url = url {
            
            let _ = Alamofire.request(url).responseJSON {
                response in
                
                if let requestResponse = response.response {
                    
                    if requestResponse.statusCode == 200 {
                        
                        if let dictionary = response.result.value as? [String: Any] {
                            
                            if let genre = dictionary["genre"] as? String {
                                
                                if let part = NSManagedObjectContext.create(entity: "Part") as? Part {
                                    
                                    part.setValue(genre, forKeyPath: "genre")
                                    
                                    if let tracks = dictionary["featured_tracks"] as? [[String: Any]] {
                                        
                                        tracks.forEach {
                                            track in
                                            
                                            if let artist = track["artist"] as? String,
                                                let name = track["name"] as? String,
                                                let stream = track["stream"] as? String,
                                                let published = track["published"] as? String,
                                                let imageSmall = track["img_small"] as? String,
                                                let imageLarge = track["img_large"] as? String {
                                                
                                                if let song = NSManagedObjectContext.create(entity: "Song") as? Song {
                                                    
                                                    song.setValue(artist, forKeyPath: "artist")
                                                    song.setValue(name, forKeyPath: "name")
                                                    song.setValue(stream, forKeyPath: "stream")
                                                    song.setValue(published, forKeyPath: "published")
                                                    song.setValue(imageSmall, forKeyPath: "imageSmall")
                                                    song.setValue(imageLarge, forKeyPath: "imageLarge")
                                                    
                                                    part.addToSongs(song)
                                                }
                                            }
                                        }
                                    }
                                    
                                    completion(part)
                                    return
                                }
                                
                            }
                        }
                    }
                }
            }
            
            completion(nil)
            return
        }
    }
}
