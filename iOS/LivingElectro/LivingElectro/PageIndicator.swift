//
//  PageIndicator.swift
//  LivingElectro
//
//  Created by iOS Developer on 15/05/2017.
//  Copyright © 2017 Hivinau GRAFFE. All rights reserved.
//

import UIKit

@objc public protocol PageIndicatorDelegate: class {
    
    @objc func pageIndicatorWillChangeLineViewWithFrame(_ pageIndicator: PageIndicator) -> CGRect
}

@objc(PageIndicator)
public class PageIndicator: UIViewController {
    
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var lineViewLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var lineViewWidthConstraint: NSLayoutConstraint!
    
    public var delegate: PageIndicatorDelegate?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        lineView.backgroundColor = .white
    }
    
    public func updateLineViewFrame() {
        
        view.layoutIfNeeded()
        
        let rect = delegate!.pageIndicatorWillChangeLineViewWithFrame(self)
        
        lineViewLeftConstraint.constant = rect.origin.x
        lineViewWidthConstraint.constant = rect.size.width
        
        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       options: [.curveLinear, .beginFromCurrentState],
                       animations: {
                        [unowned self] () -> Void in
                        
                        self.view.layoutIfNeeded()
            }, completion: nil)

    }
}
