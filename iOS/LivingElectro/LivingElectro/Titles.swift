//
//  Titles.swift
//  LivingElectro
//
//  Created by Aude Sautier on 13/05/2017.
//  Copyright © 2017 Hivinau GRAFFE. All rights reserved.
//

import UIKit

@objc(Titles)
public class Titles: UICollectionViewController {
    
    public var titles: [String?]?
    public var sizes = [Int: CGSize]()
    
    public override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: nil, completion: {
            _ in
            
            self.collectionView?.collectionViewLayout.invalidateLayout()
        })
    }

    
    public override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var count = 0
        
        if let titles = titles {
            
            count = titles.count
        }
        
        return count
    }
    
    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "titleCell", for: indexPath) as? TitleCell {
            
            if let titles = titles,
                indexPath.row < titles.count {
                
                cell.titleValue = titles[indexPath.row]
                
                sizes[indexPath.row] = cell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
                
                return cell
            }
        }
        
        return super.collectionView(collectionView, cellForItemAt: indexPath)
    }
}

extension Titles: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if var size = sizes[indexPath.row] {
            
            size.height = collectionView.bounds.size.height
            
            return size
        }
        
        return collectionView.bounds.size
    }
}
