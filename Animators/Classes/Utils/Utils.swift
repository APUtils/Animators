//
//  Utils.swift
//  Pods
//
//  Created by Anton Plebanovich on 12/12/17.
//  
//

import UIKit


func _g_configureNavigationAnimations(navigationController: UINavigationController, delegate: UINavigationControllerDelegate) {
    navigationController.delegate = delegate
}

func _g_configurePresentationAnimations(viewController: UIViewController, delegate: UIViewControllerTransitioningDelegate) {
    assert(viewController.isViewLoaded == false, "Configuration should occur before -viewDidLoad. Usually in -awakeFromNib.")
    viewController.modalPresentationStyle = .custom
    viewController.modalPresentationCapturesStatusBarAppearance = true
    viewController.transitioningDelegate = delegate
}
