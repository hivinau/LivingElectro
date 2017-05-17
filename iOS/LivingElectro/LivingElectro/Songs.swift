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

@objc(Songs)
public class Songs: UITableViewController {
    
    public var songs: [Song?]?
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
                
                if let song = songs[indexPath.row] {
                    
                    songCell.songValue = song.value(forKeyPath: "title") as? String
                    
                    if !tableView.isDragging && !tableView.isDecelerating {
                        
                        if let url = song.value(forKeyPath: "image") as? String {
                            
                            downloadImage(from: url, for: indexPath)
                        }
                    }
                }
            }
            
            songCell.songImage = UIImage(named: "placeholder")
            
            return songCell
        }
        
        return super.tableView(tableView, cellForRowAt: indexPath)
    }
    
    public override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if !decelerate {
            
            scrollViewDidEndDecelerating(scrollView)
        }
    }
    
    public override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if let indexPaths = tableView.indexPathsForVisibleRows {
            
            indexPaths.forEach({
                indexPath in
                
                if let songs = songs,
                    indexPath.row < songs.count {
                    
                    if let song = songs[indexPath.row] {
                        
                        if let url = song.value(forKeyPath: "image") as? String {
                            
                            downloadImage(from: url, for: indexPath)
                        }
                    }
                }
            })
        }
    }

    
    private func downloadImage(from url: String, for indexPath: IndexPath) {
        
        do {
            
            var urlRequest = try URLRequest(url: url, method: .get)
            urlRequest.cachePolicy = .returnCacheDataElseLoad

            downloader.download(urlRequest) {
                [unowned self] response in
                
                if let image = response.result.value,
                    let songCell = self.tableView.cellForRow(at: indexPath) as? SongCell {
                    
                    songCell.songImage = image
                }
            }

        } catch {
            
            if let songCell = self.tableView.cellForRow(at: indexPath) as? SongCell {
                
                songCell.songImage = UIImage(named: "placeholder")
            }
        }
    }
}
