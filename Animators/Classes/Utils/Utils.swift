//
//  Utils.swift
//  Animators
//
//  Created by Anton Plebanovich on 12/12/17.
//  Copyright © 2017 Anton Plebanovich. All rights reserved.
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
