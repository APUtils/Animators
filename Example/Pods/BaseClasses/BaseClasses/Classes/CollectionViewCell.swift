//
//  CollectionViewCell.swift
//  Base Classes
//
//  Created by Anton Plebanovich on 11/10/17.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import UIKit


/// CollectionViewCell with `reuseId` property.
open class CollectionViewCell: UICollectionViewCell {
    
    // ******************************* MARK: - Public Properties
    
    /// Increases every time cell was reused. May be used to determine if async update should be performed in this cell.
    private(set) open var reuseId: UInt = 0
    
    // ******************************* MARK: - CollectionViewCell Overrides
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        
        changeReuseId()
    }
    
    // ******************************* MARK: - Private Methods
    
    private func changeReuseId() {
        reuseId = reuseId &+ 1
    }
}
