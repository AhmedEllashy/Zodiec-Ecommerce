//
//  BorderExtension.swift
//  Zodiec
//
//  Created by Ahmad Ellashy on 25/07/2023.
//

import UIKit

extension UIView {
    func RectangleBorderRadius (){
        self.layer.borderWidth = 0.6
        self.layer.borderColor = UIColor.black.cgColor.copy(alpha: 0.3)
        self.layer.cornerRadius = 8.0
    }
    func RoundedBorderRadius (){
        self.layer.borderWidth = 0.6
        self.layer.borderColor = UIColor.black.cgColor.copy(alpha: 0.3)
        self.layer.cornerRadius = 25
    }
    func circluteView(){
        self.layer.borderWidth = 0.6
        self.layer.borderColor = UIColor.black.cgColor.copy(alpha: 0.3)
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
    }
    
    func addShadow(opacity : Float = 0.23 , radius : CGFloat = 4, offSet : CGSize = CGSize(width: 0, height: 0), color : CGColor = UIColor.black.cgColor){
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
        self.layer.shadowOffset = offSet
        self.layer.shadowColor = color
        self.layer.cornerRadius = 12.5

    }
}
