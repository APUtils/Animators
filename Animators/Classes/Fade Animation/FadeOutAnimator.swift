//
//  FadeOutAnimator.swift
//  Animators
//
//  Created by Anton Plebanovich on 28/05/16.
//  Copyright © 2016 Anton Plebanovich. All rights reserved.
//

import UIKit


public final class FadeOutAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    public final func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    public final func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let
            fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let fromView = fromVC.view,
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let toView = toVC.view
            else { return }
        
        if toView.superview == nil {
            let containerView = transitionContext.containerView
            containerView.insertSubview(toView, at: 0)
        }
        
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
            fromView.alpha = 0
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
