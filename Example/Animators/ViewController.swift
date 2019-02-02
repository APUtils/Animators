//
//  ViewController.swift
//  Animators
//
//  Created by Anton Plebanovich on 07/31/2017.
//  Copyright (c) 2017 Anton Plebanovich. All rights reserved.
//

import UIKit
import Animators
import APExtensions


final class ViewController: UIViewController {
    
    // ******************************* MARK: - Private Properties
    
    private var animationDelegate: RightSlideAnimationDelegate!
    
    // ******************************* MARK: - Enums
    
    enum ViewControllerAnimationType {
        case none
        case fadePresentation
        case bottomSlidePresentation
        case rightSlidePresentation
    }
    
    // ******************************* MARK: - Private Properties
    
    private var type: ViewControllerAnimationType = .none {
        didSet {
            switch type {
            case .none:
                navigationController?.delegate = nil
                modalPresentationStyle = .fullScreen
                transitioningDelegate = nil
                
            case .fadePresentation:
                FadeAnimationDelegate.configurePresentationAnimations(viewController: self)
                
            case .bottomSlidePresentation:
                BottomSlideAnimationDelegate.configurePresentationAnimations(viewController: self)
                
            case .rightSlidePresentation:
                animationDelegate = RightSlideAnimationDelegate(viewController: self)
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        FadeAnimationDelegate.configurePresentationAnimations(viewController: self)
    }
    // ******************************* MARK: - Initialization, Setup and Configuration
    
    private static func create() -> ViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: className) as! ViewController
        
        return vc
    }
    
    static func create(type: ViewControllerAnimationType) -> ViewController {
        let vc = create()
        vc.type = type
        
        return vc
    }
    
    // ******************************* MARK: - UIViewController Methods
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
