//
//  NavigationController.swift
//  Base Classes
//
//  Created by Anton Plebanovich on 5/29/17.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import UIKit


/// NavigationControler that pays attantion to its child controlers for status bar style
open class NavigationController: UINavigationController {
    
    // ******************************* MARK: - UIViewController Methods
    
    open override var childForScreenEdgesDeferringSystemGestures: UIViewController? {
        return topViewController
    }
    
    open override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
}
