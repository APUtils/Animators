//
//  NavigationController.swift
//  Base Classes
//
//  Created by Anton Plebanovich on 5/29/17.
//  Copyright © 2017 Anton Plebanovich. All rights reserved.
//

import UIKit


class NavigationController: UINavigationController {
    
    //-----------------------------------------------------------------------------
    // MARK: - UIViewController Methods
    //-----------------------------------------------------------------------------
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var childViewControllerForStatusBarStyle: UIViewController? {
        return topViewController
    }
}
