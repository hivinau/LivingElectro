//
//  Songs.swift
//  LivingElectro
//
//  Created by Aude Sautier on 13/05/2017.
//  Copyright © 2017 Hivinau GRAFFE. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import CoreData

@objc(Songs)
public class Songs: UITableViewController {
    
    public var songs: [Song]?
    private var dateFormatter = DateFormatter()
    private var downloader = ImageDownloader(configuration: ImageDownloader.defaultURLSessionConfiguration(),
                                             downloadPrioritization: .fifo,
                                             maximumActiveDownloads: 4,
                                             imageCache: AutoPurgingImageCache())
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = true
        tableView.alwaysBounceVertical = true
        
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        loadSongs()
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count = 0
        
        if let songs = songs {
            
            count = songs.count
        }
        
        return count
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 140.0 as CGFloat
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let songCell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath) as? SongCell {
            
            if let songs = songs,
                indexPath.row < songs.count {
                
                let song = songs[indexPath.row]
                songCell.songValue = song.value(forKeyPath: "name") as? String
                
                if let url = song.value(forKeyPath: "imageLarge") as? String {
                    
                    songCell.songImage = url
                }
            }
            
            return songCell
        }
        
        return super.tableView(tableView, cellForRowAt: indexPath)
    }
    
    private func loadSongs() {
        
        if let genre = title {
            
            if let url = url(for: genre, page: 0) {
                
                Part.load(from: url) {
                    [unowned self] part in
                    
                    if let part = part,
                        let songs = part.songs {
                        
                        self.songs = songs.sorted(by: {
                            lhs, rhs in
                            
                            if let lhs = lhs as? NSManagedObject,
                                let rhs = rhs as? NSManagedObject {
                                
                                if let lhsDateString = lhs.value(forKeyPath: "published") as? String,
                                    let rhsDateString = rhs.value(forKeyPath: "published") as? String {
                                    
                                    if let lhsDate = self.dateFormatter.date(from: lhsDateString),
                                        let rhsDate = self.dateFormatter.date(from: rhsDateString) {
                                        
                                        return lhsDate.compare(rhsDate) == .orderedDescending
                                    }
                                }
                            }
                            
                            return false
                            
                        }) as? [Song]
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    private func url(for genre: String, page: Int) -> String? {
        
        if let host = ApiHelper.value(for: "host") as? String,
            let route = ApiHelper.value(for: "listByGenre") as? String {
            
            let template = String(format: "%@%@", host, route)
            
            return String(format: template, genre, page)
        }
        
        return nil
    }
}
