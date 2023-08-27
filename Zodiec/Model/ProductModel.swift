//
//  ProductModel.swift
//  Zodiec
//
//  Created by Ahmad Ellashy on 31/07/2023.
//

import UIKit

class ProductModel {
    var id : String?
    var name : String?
    var category : String?
    var image : String?
    var price : String?
    var quantity : Int?
    var sizes : [String]?
    var rate : Int?
    
    init(_data : NSDictionary){
        id = _data["id"] as? String
        name = _data["name"] as? String
        category = _data["category"] as? String
        image = _data["image"] as? String
        price = _data["price"] as? String
        quantity = _data["quantity"] as? Int
        sizes = _data["size"] as? [String]
        rate = _data["rate"] as? Int
    }
    init(id : String? , name : String? ,category : String? ,image : String? , price : String? , quantity : Int?, sizes : [String]? , rate : Int?){
        self.id = id
        self.name = name
        self.category = category
        self.image = image
        self.price = price
        self.quantity = quantity
        self.sizes = sizes
        self.rate = rate
    }
    
}
