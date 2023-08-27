//
//  CategoryModel.swift
//  Zodiec
//
//  Created by Ahmad Ellashy on 31/07/2023.
//

import UIKit

class CategoryModel {
    var id : String?
    var name : String?
   
    init(_data : NSDictionary){
        id = _data["id"] as? String
        name = _data["name"] as? String
    }
    init(id : String? , name : String?){
        self.id = id
        self.name = name
    }
}

