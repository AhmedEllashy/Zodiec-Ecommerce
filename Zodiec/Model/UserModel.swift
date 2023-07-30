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
    var address : Address?
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
        date = _data["date"] as? Timestamp
    }
    init(uid : String? , userName : String? , email : String?,mobileNumber : String? , password : String? , imageUrl : String? , status : String? , token : String? , date : Timestamp? ){
        self.uid = uid
        self.userName = userName
        self.email = email
        self.mobileNumber = mobileNumber
        self.password = password
        self.imageUrl = imageUrl
        self.status = status
        self.token = token
        self.date = date
    }
}

struct Address : Codable {
    
}
