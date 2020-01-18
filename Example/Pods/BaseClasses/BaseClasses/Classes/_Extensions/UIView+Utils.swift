//
//  UIView+Utils.swift
//  Base Classes
//
//  Created by Anton Plebanovich on 12/7/17.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import UIKit


extension UIView {
    /// Gets view's top most superview
    var _rootView: UIView {
        return superview?._rootView ?? self
    }
    
    /// Returns all view's superviews
    var _allSuperviews: [UIView] {
        var allSuperviews: [UIView] = []
        var _superview = self.superview
        while let superview = _superview {
            allSuperviews.append(superview)
            _superview = superview.superview
        }
        
        return allSuperviews
    }
}
