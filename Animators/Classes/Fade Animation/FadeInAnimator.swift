//
//  FadeInAnimator.swift
//  Animators
//
//  Created by Anton Plebanovich on 28/05/16.
//  Copyright © 2016 Anton Plebanovich. All rights reserved.
//

import UIKit


public final class FadeInAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    // ******************************* MARK: - UIViewControllerAnimatedTransitioning
    
    public final func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    public final func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let
            fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let _ = fromVC.view,
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let toView = toVC.view
            else { return }
        
        let containerView = transitionContext.containerView
        toView.frame = transitionContext.finalFrame(for: toVC)
        toView.alpha = 0
        containerView.addSubview(toView)
        
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
            toView.alpha = 1
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
