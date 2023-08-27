//
//  CartProductModel.swift
//  Zodiec
//
//  Created by Ahmad Ellashy on 05/08/2023.
//

import UIKit

class CartModel {
    var product : ProductModel?
    var quantity : Int?
    
    init(_data : NSDictionary) {
        product = ProductModel(_data: _data["product"] as! NSDictionary)
        quantity = _data["quantity"] as? Int
    }
    init(product : ProductModel?, quantity : Int){
        self.product = product
        self.quantity = quantity
    }
}

