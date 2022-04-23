//
//  UIView.swift
//  Level
//
//  Created by Pratik on 15/12/21.
//

import Foundation
import UIKit

extension UIView {
    
    func dropShadow() {

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize.zero
        layer.masksToBounds = false
        
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 4.0
        layer.rasterizationScale = UIScreen.main.scale
        layer.shouldRasterize = true
    }
    
    func addDashedBorder(_ color: UIColor = UIColor.black, withWidth width: CGFloat = 2, cornerRadius: CGFloat = 5, dashPattern: [NSNumber] = [3,6]) {

      let shapeLayer = CAShapeLayer()

      shapeLayer.bounds = bounds
      shapeLayer.position = CGPoint(x: bounds.width/2, y: bounds.height/2)
      shapeLayer.fillColor = nil
      shapeLayer.strokeColor = color.cgColor
      shapeLayer.lineWidth = width
      shapeLayer.lineJoin = CAShapeLayerLineJoin.round // Updated in swift 4.2
      shapeLayer.lineDashPattern = dashPattern
      shapeLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath

      self.layer.addSublayer(shapeLayer)
    }
}

extension UIView {
    public func addInnerShadow(topColor: UIColor = UIColor.white) {
        let shadowLayer = CAGradientLayer()
        shadowLayer.cornerRadius = layer.cornerRadius
        shadowLayer.frame = bounds
        shadowLayer.frame.size.height = 10.0
        shadowLayer.colors = [
            topColor.cgColor,
            UIColor.white.withAlphaComponent(0).cgColor
        ]
        layer.addSublayer(shadowLayer)
    }
}

extension UIImageView {
    func applyshadowWithCorner(containerView : UIView, cornerRadious : CGFloat){
        containerView.clipsToBounds = false
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.1
        containerView.layer.shadowOffset = CGSize.zero
        containerView.layer.shadowRadius = 10
        containerView.layer.cornerRadius = cornerRadious
        containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: cornerRadious).cgPath
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadious
    }
}

extension UIView {
func dropInsideShadow(color: UIColor, opacity: Float = 0.2, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = opacity
    layer.shadowOffset = offSet
    layer.shadowRadius = radius

    layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }
}
