//
//  BorderExtension.swift
//  Zodiec
//
//  Created by Ahmad Ellashy on 25/07/2023.
//

import UIKit

extension UIView {
    func addBorder (){
        self.layer.borderWidth = 0.6
        self.layer.borderColor = UIColor.black.cgColor.copy(alpha: 0.3)
        self.layer.cornerRadius = 8.0
    }
    func circluteView(){
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
    }
}
