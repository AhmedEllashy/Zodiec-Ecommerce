//
//  User.swift
//  Zodiec
//
//  Created by Ahmad Ellashy on 22/07/2023.
//

import Foundation
import FirebaseFirestore

class UserModel {
    var uid  : String?
    var userName : String?
    var email : String?
    var password : String?
    var mobileNumber : String?
    var imageUrl : String?
    var status  :String?
    var token  : String?
    var address : [AddressModel]?
    var date : Timestamp?
    
    init(_data : NSDictionary){
        uid = _data["uid"] as? String
        userName = _data["userName"] as? String
        email = _data["email"] as? String
        mobileNumber = _data["mobileNumber"] as? String
        password = _data["password"] as? String
        imageUrl = _data["imageUrl"] as? String
        status = _data["status"] as? String
        token = _data["token"] as? String
        address = _data["address"] as? [AddressModel]
        date = _data["date"] as? Timestamp
    }
    init(uid : String? , userName : String? , email : String?,mobileNumber : String? , password : String? , imageUrl : String? , status : String? , token : String? ,address : [AddressModel]? ,date : Timestamp? ){
        self.uid = uid
        self.userName = userName
        self.email = email
        self.mobileNumber = mobileNumber
        self.password = password
        self.imageUrl = imageUrl
        self.status = status
        self.token = token
        self.address = address
        self.date = date
    }
}

class AddressModel {
    var id : String
    var title : String
    var street : String
    var district : String
    var governrate : String
    var moreDetails : String
    
    init(_data : NSDictionary){
        self.id = _data["id"] as! String
        self.title = _data["title"] as! String
        self.street = _data["street"] as! String
        self.district = _data["district"] as! String
        self.governrate = _data["governrate"] as! String
        self.moreDetails = _data["moreDetails"] as! String

    }
    init(id:String?,title : String, street : String, district : String, governrate : String, moreDetails : String){
        self.id = id ?? ""
        self.title = title
        self.street = street
        self.district = district
        self.governrate = governrate
        self.moreDetails = moreDetails
    }
}
