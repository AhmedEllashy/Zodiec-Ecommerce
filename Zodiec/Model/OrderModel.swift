//
//  OrderModel.swift
//  Zodiec
//
//  Created by Ahmad Ellashy on 06/12/2023.
//

import Foundation
import FirebaseFirestore


class OrderModel{
    var orderId : String?
    var products : [CartModel]?
    var total : Double?
    var status : String?
    var date : Timestamp?
    
    init(_data : NSDictionary){
        orderId = _data["id"] as? String
        for item in _data["products"] as! Array<Any> {
            products?.append(CartModel(_data: item as! NSDictionary))
        }
        total = _data["total"] as? Double
        status = _data["status"] as? String
        date = _data["date"] as? Timestamp
    }
    init(products : [CartModel]? ,total : Double? ,status : String? ,date : Timestamp?){
        self.products = products
        self.total = total
        self.status = status
        self.date = date
    }
}
