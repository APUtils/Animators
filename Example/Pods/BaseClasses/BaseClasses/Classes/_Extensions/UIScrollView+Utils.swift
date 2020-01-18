//
//  UIScrollView+Utils.swift
//  BaseClasses
//
//  Created by Anton Plebanovich on 1/3/20.
//  Copyright © 2020 Anton Plebanovich. All rights reserved.
//

import UIKit

extension UIScrollView {
    var fixedDescription: String {
        let contentInsetDescription = "{\(Int(contentInset.top)), \(Int(contentInset.left)), \(Int(contentInset.bottom)), \(Int(contentInset.right))}"
        return super.description.dropLast().appending("; contentInset = \(contentInsetDescription)>")
    }
}
