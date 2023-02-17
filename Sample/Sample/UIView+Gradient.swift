//
//  UIView+Gradient.swift
//  Sample
//
//  Created by Fotis Mitropoulos on 17/2/23.
//

import UIKit

extension UIView {
    func addGradientBackground(start: CGColor, end: CGColor, startPoint: CGPoint? = nil, endPoint: CGPoint? = nil) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [start, end]
        gradientLayer.shouldRasterize = true
        
        if let start = startPoint {
            gradientLayer.startPoint = start
        }
        
        if let end = endPoint {
            gradientLayer.endPoint = end
        }
        
        layer.addSublayer(gradientLayer)
    }
}
