//
//  CollectionView.swift
//  Base Classes
//
//  Created by Anton Plebanovich on 7/14/17.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import UIKit


/// Collection view that resizes it's cells to be the same size as collection view.
open class FullSizeCollectionView: CollectionView {
    
    // ******************************* MARK: - UIView Properties
    
    override open var bounds: CGRect {
        willSet {
            guard bounds.size != newValue.size else { return }
            configure(newSize: newValue.size)
        }
    }
    
    open override var contentInset: UIEdgeInsets {
        didSet {
            guard oldValue != contentInset else { return }
            configure(newSize: bounds.size)
        }
    }
    
    @available(iOS 11.0, *)
    @available(iOSApplicationExtension 11.0, *)
    open override func adjustedContentInsetDidChange() {
        super.adjustedContentInsetDidChange()
        configure(newSize: bounds.size)
    }
    
    // ******************************* MARK: - Private Properties
    
    private var previousSize: CGSize = .zero
    
    // ******************************* MARK: - Initialization, Setup and Configuration
    
    private func setup() {
        configure(newSize: bounds.size)
    }
    
    private func configure(newSize: CGSize) {
        var withoutInsetsSize = newSize
        if #available(iOS 11.0, iOSApplicationExtension 11.0, *) {
            withoutInsetsSize.width -= adjustedContentInset.left + adjustedContentInset.right
            withoutInsetsSize.height -= adjustedContentInset.top + adjustedContentInset.bottom
        } else {
            withoutInsetsSize.width -= contentInset.left + contentInset.right
            withoutInsetsSize.height -= contentInset.top + contentInset.bottom
        }
        
        guard previousSize != withoutInsetsSize, let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        previousSize = withoutInsetsSize
        
        flowLayout.itemSize = withoutInsetsSize
        collectionViewLayout.invalidateLayout()
        layoutIfNeeded()
    }
    
    // ******************************* MARK: - UIView Methods
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
}
