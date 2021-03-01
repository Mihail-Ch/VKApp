//
//  ShadowRoundView.swift
//  VK.
//
//  Created by Михаил Чертов on 26.01.2021.
//

import UIKit

class ShadowRoundView: UIView {

    
    @IBInspectable var borderWidth: CGFloat = 2 {
        didSet {
            self.updateBorderWidth()
        }
    }
    @IBInspectable var borderColor: UIColor = .yellow {
        didSet {
            self.updateBorderColor()
        }
    }
    @IBInspectable var shadeColor: UIColor = .black {
        didSet {
            self.updateColors()
        }
    }
    @IBInspectable var shadeTransparency: CGFloat = 0.5 {
        didSet {
            self.updateTransparency()
        }
    }
    @IBInspectable var shadeRadius: CGFloat = 8 {
        didSet {
            self.updateRadius()
        }
    }
    @IBInspectable  var shadeOffset: CGSize = .zero {
        didSet {
            self.updateOffset()
        }
    }
    
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }
    
    func updateBorderWidth() {
        self.layer.borderWidth = self.borderWidth
    }
    
    func updateBorderColor() {
        self.layer.borderColor = self.borderColor.cgColor
    }

    func updateColors() {
        self.layer.shadowColor = self.shadeColor.cgColor
    }
    
    func updateTransparency() {
        self.layer.shadowOpacity = Float(shadeTransparency)
    }
    
    func updateRadius() {
        self.layer.shadowRadius = shadeRadius
    }
    
    func updateOffset() {
        self.layer.shadowOffset = shadeOffset
    }
    

}


    


