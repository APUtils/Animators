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
final public class RightSlideAnimationDelegate: NSObject {
    
    // ******************************* MARK: - Types
    
    enum Mode {
        case presentation(UIViewController)
        case navigation(UINavigationController)
        
        var view: UIView {
            switch self {
            case .navigation(let navigationController): return navigationController.view
            case .presentation(let viewController): return viewController.view
            }
        }
    }
    
    // ******************************* MARK: - Public Properties
    
    public var isInteractivePopGestureRecognizerEnabled: Bool = true
    
    // ******************************* MARK: - Private Properties
    
    private let mode: Mode
    private let rightSlideInAnimator = RightSlideInAnimator()
    private let rightSlideOutAnimator = RightSlideOutAnimator()
    private let dismissRecognizer: UIPanGestureRecognizer = UIPanGestureRecognizer()
    private var percentDrivenTransition: UIPercentDrivenInteractiveTransition?
    
    // ******************************* MARK: - Initialization and Setup
    
    /// Use this method to configure UINavigationController push/pop animations
    public init(navigationController: UINavigationController) {
        self.mode = .navigation(navigationController)
        super.init()
        setup()
    }
    
    /// Use this method to configure UIViewController present/dismiss animations.
    /// Configuration should occur before -viewDidLoad. Usually in -awakeFromNib.
    public init(viewController: UIViewController) {
        self.mode = .presentation(viewController)
        super.init()
        setup()
    }
    
    private func setup() {
        dismissRecognizer.addTarget(self, action: #selector(handleGesture(_:)))
        dismissRecognizer.delegate = self
        
        switch mode {
        case .navigation(let navigationController):
            _g_configureNavigationAnimations(navigationController: navigationController, delegate: self)
            navigationController.view.addGestureRecognizer(dismissRecognizer)
            
        case .presentation(let viewController):
            _g_configurePresentationAnimations(viewController: viewController, delegate: self)
            viewController.view.addGestureRecognizer(dismissRecognizer)
        }
    }
    
    deinit {
        dismissRecognizer.view?.removeGestureRecognizer(dismissRecognizer)
    }
    
    // ******************************* MARK: - Actions
    
    @objc private func handleGesture(_ recognizer: UIPanGestureRecognizer) {
        guard let view = recognizer.view else { return }
        let progress = recognizer.translation(in: view).x / view.bounds.width
        
        switch recognizer.state {
        case .began:
            percentDrivenTransition = UIPercentDrivenInteractiveTransition()
            percentDrivenTransition?.completionCurve = .linear
            
            switch mode {
            case .navigation(let navigationController): navigationController.popViewController(animated: true)
            case .presentation(let viewController): viewController.dismiss(animated: true)
            }
            
        case .changed:
            percentDrivenTransition?.update(progress)
            
        case .ended, .cancelled, .failed:
            let velocity = recognizer.velocity(in: recognizer.view)
            percentDrivenTransition?.completionSpeed = 0.999  // https://stackoverflow.com/a/42972283/1271826
            if (progress > 0.5 && velocity.x == 0) || velocity.x > 0 {
                percentDrivenTransition?.finish()
            } else {
                percentDrivenTransition?.cancel()
            }
            percentDrivenTransition = nil
            
        case .possible:
            break
        }
    }
}

// ******************************* MARK: - UIViewControllerAnimatedTransitioning

extension RightSlideAnimationDelegate: UIViewControllerTransitioningDelegate {
    public final func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return rightSlideInAnimator
    }
    
    public final func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return rightSlideOutAnimator
    }
    
    public func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    
    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return percentDrivenTransition
    }
}

// ******************************* MARK: - UINavigationControllerDelegate

extension RightSlideAnimationDelegate: UINavigationControllerDelegate {
    public final func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push: return rightSlideInAnimator
        case .pop: return rightSlideOutAnimator
        case .none: return nil
        }
    }
    
    public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return percentDrivenTransition
    }
}

extension RightSlideAnimationDelegate: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard isInteractivePopGestureRecognizerEnabled else { return false }
        
        let point = touch.location(in: mode.view)
        return point.x < 12
    }
}
