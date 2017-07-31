//
//  RightSlideInAnimator.swift
//  Animators
//
//  Created by Anton Plebanovich on 5/24/17.
//  Copyright © 2017 Anton Plebanovich. All rights reserved.
//

import UIKit


public final class RightSlideInAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    public final func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.7
    }
    
    public final func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVc = transitionContext.viewController(forKey: .from)!
        let fromView = fromVc.view!
        let toVc = transitionContext.viewController(forKey: .to)!
        let toView = toVc.view!
        let containerView = transitionContext.containerView
        
        toView.frame = fromView.frame
        toView.frame.origin.x += fromView.bounds.width
        containerView.addSubview(toView)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.4, options: [.beginFromCurrentState], animations: {
            fromView.frame.origin.x -= fromView.bounds.width
            toView.frame.origin.x -= fromView.bounds.width
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
