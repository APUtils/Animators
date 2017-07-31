//
//  BottomSlideOutAnimator.swift
//  Animators
//
//  Created by Anton Plebanovich on 5/25/17.
//  Copyright © 2017 Anton Plebanovich. All rights reserved.
//

import UIKit


public final class BottomSlideOutAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    public final func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    public final func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let duration = transitionDuration(using: transitionContext)
        let fromVc = transitionContext.viewController(forKey: .from)!
        let fromView = fromVc.view!
        let toVc = transitionContext.viewController(forKey: .to)!
        let toView = toVc.view!
        
        if toView.superview == nil {
            let containerView = transitionContext.containerView
            containerView.insertSubview(toView, at: 0)
        }
        
        toView.frame = fromView.frame
        
        UIView.animate(withDuration: duration, delay: 0, options: [.beginFromCurrentState], animations: {
            toView.alpha = 1
        })
        
        UIView.animate(withDuration: duration, animations: {
            fromView.frame.origin.y += fromView.bounds.height
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
