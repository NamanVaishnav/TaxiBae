//
//  UIViewAnimationExt.swift
//  TaxiBae
//
//  Created by naman vaishnav on 15/10/18.
//  Copyright © 2018 naman vaishnav. All rights reserved.
//

import UIKit

extension UIView {
    func fadeTo(alphaValue: CGFloat, withDuration duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.alpha = alphaValue
        }
    }
}


