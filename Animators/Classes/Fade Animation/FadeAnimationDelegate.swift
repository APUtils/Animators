//
//  FadeAnimationDelegate.swift
//  Animators
//
//  Created by Anton Plebanovich on 29/05/16.
//  Copyright © 2016 Anton Plebanovich. All rights reserved.
//

import UIKit


/// Delegation object for fade presentation and navigation animations. 
/// Call `configureNavigationAnimations(navigationController:)` to configure navigation animations 
/// or `configurePresentationAnimations(viewController:)` to configure presentation animations.
///
/// Just simple fade in and fade out animation.
public final class FadeAnimationDelegate: NSObject {
    
    //-----------------------------------------------------------------------------
    // MARK: - Class Properties
    //-----------------------------------------------------------------------------
    
    public static var sharedInstance = FadeAnimationDelegate()
    
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
    // MARK: - Private properties
    //-----------------------------------------------------------------------------
    
    final private var fadeInAnimator = FadeInAnimator()
    final private var fadeOutAnimator = FadeOutAnimator()
}

//-----------------------------------------------------------------------------
// MARK: - UIViewControllerAnimatedTransitioning
//-----------------------------------------------------------------------------

extension FadeAnimationDelegate: UIViewControllerTransitioningDelegate {
    public final func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return fadeInAnimator
    }
    
    public final func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return fadeOutAnimator
    }
}

//-----------------------------------------------------------------------------
// MARK: - UINavigationControllerDelegate
//-----------------------------------------------------------------------------

extension FadeAnimationDelegate: UINavigationControllerDelegate {
    public final func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            return fadeInAnimator
        case .pop:
            return fadeOutAnimator
        case .none:
            return nil
        }
    }
}
