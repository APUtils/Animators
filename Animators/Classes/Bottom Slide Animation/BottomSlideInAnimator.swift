//
//  BottomSlideInAnimator.swift
//  Animators
//
//  Created by Anton Plebanovich on 5/25/17.
//  Copyright © 2017 Anton Plebanovich. All rights reserved.
//

import UIKit


public final class BottomSlideInAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    public final func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    public final func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let duration = transitionDuration(using: transitionContext)
        let fromVc = transitionContext.viewController(forKey: .from)!
        let fromView = fromVc.view!
        let toVc = transitionContext.viewController(forKey: .to)!
        let toView = toVc.view!
        let containerView = transitionContext.containerView
        
        toView.frame = fromView.frame
        toView.frame.origin.y += fromView.bounds.height
        containerView.addSubview(toView)
        UIView.animate(withDuration: duration / 2) { 
            fromView.alpha = 0
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: [.beginFromCurrentState], animations: { 
            toView.frame = transitionContext.finalFrame(for: toVc)
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
