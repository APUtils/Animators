//
//  MainViewController.swift
//  Animators
//
//  Created by Anton Plebanovich on 7/31/17.
//  Copyright © 2017 Anton Plebanovich. All rights reserved.
//

import UIKit
import Animators


final class MainViewController: UIViewController {
    
    //-----------------------------------------------------------------------------
    // MARK: - UIViewController Methods
    //-----------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RightSlideAnimationDelegate.configureNavigationAnimations(navigationController: navigationController!)
    }
    
    //-----------------------------------------------------------------------------
    // MARK: - Private Methods - Actions
    //-----------------------------------------------------------------------------
    
    @IBAction private func onFadePresentationTap(_ sender: Any) {
        let vc = ViewController.create(type: .fadePresentation)
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction private func onBottomSlidePresentationTap(_ sender: Any) {
        let vc = ViewController.create(type: .bottomSlidePresentation)
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction private func onRightSlidePresentationTap(_ sender: Any) {
        let vc = ViewController.create(type: .rightSlidePresentation)
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction private func onFadeNavigationTap(_ sender: Any) {
        FadeAnimationDelegate.configureNavigationAnimations(navigationController: navigationController!)
        
        let vc = ViewController.create(type: .none)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction private func onBottomSlideNavigationTap(_ sender: Any) {
        BottomSlideAnimationDelegate.configureNavigationAnimations(navigationController: navigationController!)
        
        let vc = ViewController.create(type: .none)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction private func onRightSlideNavigationTap(_ sender: Any) {
        RightSlideAnimationDelegate.configureNavigationAnimations(navigationController: navigationController!)
        
        let vc = ViewController.create(type: .none)
        navigationController?.pushViewController(vc, animated: true)
    }
}
