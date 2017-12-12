//
//  RightSlideAnimationDelegate.swift
//  Animators
//
//  Created by Anton Plebanovich on 7/31/17.
//  Copyright © 2017 Anton Plebanovich. All rights reserved.
//

import UIKit


/// Delegation object for fade presentation and navigation animations.
/// Call `configureNavigationAnimations(navigationController:)` to configure navigation animations
/// or `configurePresentationAnimations(viewController:)` to configure presentation animations.
///
/// Slide from right side with bounces.
public final class RightSlideAnimationDelegate: NSObject {
    
    //-----------------------------------------------------------------------------
    // MARK: - Class Properties
    //-----------------------------------------------------------------------------
    
    public static var sharedInstance = RightSlideAnimationDelegate()
    
    //-----------------------------------------------------------------------------
    // MARK: - Class Methods
    //-----------------------------------------------------------------------------
    
    /// Use this method to configure UINavigationController push/pop animations
    public static func configureNavigationAnimations(navigationController: UINavigationController) {
        _g_configureNavigationAnimations(navigationController: navigationController, delegate: sharedInstance)
    }
    
    /// Use this method to configure UIViewController present/dismiss animations
    public static func configurePresentationAnimations(viewController: UIViewController) {
        _g_configurePresentationAnimations(viewController: viewController, delegate: sharedInstance)
    }
    
    //-----------------------------------------------------------------------------
    // MARK: - Private Properties
    //-----------------------------------------------------------------------------
    
    final private let rightSlideInAnimator = RightSlideInAnimator()
    final private let rightSlideOutAnimator = RightSlideOutAnimator()
}

//-----------------------------------------------------------------------------
// MARK: - UIViewControllerAnimatedTransitioning
//-----------------------------------------------------------------------------

extension RightSlideAnimationDelegate: UIViewControllerTransitioningDelegate {
    public final func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return rightSlideInAnimator
    }
    
    public final func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return rightSlideOutAnimator
    }
}

//-----------------------------------------------------------------------------
// MARK: - UINavigationControllerDelegate
//-----------------------------------------------------------------------------

extension RightSlideAnimationDelegate: UINavigationControllerDelegate {
    public final func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            return rightSlideInAnimator
        case .pop:
            return rightSlideOutAnimator
        case .none:
            return nil
        }
    }
}
