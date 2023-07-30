//
//  app_Api.swift
//  Zodiec
//
//  Created by Ahmad Ellashy on 22/07/2023.
//

import Foundation
import FirebaseFirestore
import UIKit
class ApiManager {
    let db = Firestore.firestore()
    //MARK: - ADD User Method
    func addUser(completion : @escaping (_ data : Any? ,_ error : String?) -> Void,user : UserModel?){
        db.collection(FirebaseCollections.Users.rawValue).document(user!.uid!)
            .setData([
            "uid" : user!.uid!,
            "userName" : user?.userName ?? "",
            "email" : user?.email ?? "",
            "password" : user?.password ?? "",
            "mobileNumber" : user?.mobileNumber ?? "",
//            "address" : []
            
            ] as [String : Any]){err in
            if err != nil {
                completion(nil, err?.localizedDescription)

            }
        }
        
    }
    
    //MARK: - GET User Method
    func getUser(completion : @escaping (_ data : UserModel? ,_ error : String?) -> Void,email : String){
        db.collection(FirebaseCollections.Users.rawValue).getDocuments { querySnapshot, error in
            if error == nil {
                if let snapShot = querySnapshot {
                    for doc in snapShot.documents {
                        let newDoc = doc.data()
                        if newDoc["email"] as! String != email {
                            completion(nil , ErrorStrings.pleaseSignUp)
                        }else{
                            let userData = UserModel(_data: newDoc as NSDictionary)
                            completion(userData , nil)
                        }
                    }
                }
            }else{
                completion(nil , error?.localizedDescription)
            }
        }
        
    }
  
}
