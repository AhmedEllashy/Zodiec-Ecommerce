//
//  CouponModel.swift
//  Zodiec
//
//  Created by Ahmad Ellashy on 14/08/2023.
//

import UIKit

struct CouponModel{
    var id : String?
    var code : String?
    var discount : Double?
    
    init(_id : String? , _code : String?,_discount : Double?){
        id = _id
        code = _code
        discount = _discount
    }
    init(_data  :NSDictionary) {
        id = _data["id"] as? String
        code = _data["code"] as? String
        discount = _data["discount"] as? Double
    }
}
