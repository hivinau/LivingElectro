//
//  RowSelecting.swift
//  LivingElectro
//
//  Created by iOS Developer on 17/05/2017.
//  Copyright © 2017 Hivinau GRAFFE. All rights reserved.
//

import UIKit

public protocol RowSelecting: class {
    
    func selectRow(at indexPath: IndexPath)
}
