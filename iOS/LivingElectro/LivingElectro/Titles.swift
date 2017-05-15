//
//  Titles.swift
//  LivingElectro
//
//  Created by Aude Sautier on 13/05/2017.
//  Copyright © 2017 Hivinau GRAFFE. All rights reserved.
//

import UIKit

@objc(Titles)
public class Titles: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    public var sizes = [Int: CGSize]()
    public var titles: [String?]? {
        didSet {
            
            calculateTextSizes()
        }
    }
    
    public var pageIndicator: PageIndicator? {
        didSet {
            
            pageIndicator?.delegate = self
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = true
        collectionView.alwaysBounceHorizontal = true
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        notify()
    }
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let pageIndicator = segue.destination as? PageIndicator {
            
            self.pageIndicator = pageIndicator
        }
    }
}

extension Titles: UICollectionViewDataSource, UICollectionViewDelegate {

    public override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: nil, completion: {
            _ in
            
            self.calculateTextSizes()
            self.collectionView.collectionViewLayout.invalidateLayout()
        })
    }

    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var count = 0
        
        if let titles = titles {
            
            count = titles.count
        }
        
        return count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "titleCell", for: indexPath) as! TitleCell
        
        if let titles = titles,
            indexPath.row < titles.count {
            
            cell.titleValue = titles[indexPath.row]
        }
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        notify()
    }
}

extension Titles: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row < sizes.count,
            var size = sizes[indexPath.row] {
            
            size.height = collectionView.bounds.size.height
            
            return size
        }
        
        return collectionView.bounds.size
    }
    
    public func calculateTextSizes() {
        
        if let titles = titles {
            
            if let font = UIFont(name: "Helvetica", size: 14.0) {
                
                for i in 0 ... titles.count - 1 {
                    
                    if let title = titles[i] as NSString? {
                        
                        let indexPath = IndexPath(row: i, section: 0)
                        
                        sizes[indexPath.row] = title.size(attributes: [NSFontAttributeName: font])
                    }
                }
            }
        }
    }
}

extension Titles {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        notify()
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if !decelerate {
            
            scrollViewDidEndDecelerating(scrollView)
        }
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
        scrollViewDidEndDecelerating(scrollView)
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        notify()
    }

    public func notify() {
        
        pageIndicator?.updateLineViewFrame()
    }
}

extension Titles: PageIndicatorDelegate {
    
    public func pageIndicatorWillChangeLineViewWithFrame(_ pageIndicator: PageIndicator) -> CGRect {
        
        if let indexPaths = collectionView.indexPathsForSelectedItems {
            
            for indexPath in indexPaths {
                
                if let attributes = collectionView.layoutAttributesForItem(at: indexPath) {
                    
                    return collectionView.convert(attributes.frame, to: nil)
                }
            }
        }
        
        return CGRect.zero
    }
}
