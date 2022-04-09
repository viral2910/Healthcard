//
//  UIButton.swift
//  Level
//
//  Created by Pratik on 17/12/21.
//

import Foundation
import UIKit

extension UIButton {
    
    func dropBtnShadow() {

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize.zero
        layer.masksToBounds = false

        layer.shadowOpacity = 0.2
        layer.shadowRadius = 4.0
        layer.rasterizationScale = UIScreen.main.scale
        layer.shouldRasterize = true
    }
    
}

extension UIButton {
    //MARK:- Animate check mark
    func checkboxAnimation(closure: @escaping () -> Void){
        guard let image = self.imageView else {return}
        self.adjustsImageWhenHighlighted = false
        self.isHighlighted = false
        
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
            image.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            
        }) { (success) in
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
                self.isSelected = !self.isSelected
                //to-do
                closure()
                image.transform = .identity
            }, completion: nil)
        }
        
    }
}
