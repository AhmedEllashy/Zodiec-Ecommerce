//
//  app_Api.swift
//  Zodiec
//
//  Created by Ahmad Ellashy on 22/07/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import UIKit
import SwiftUI
class ApiManager {
    let db = Firestore.firestore()
    let auth =  Auth.auth()
    //MARK: - ADD User Method
    func addUser(completion : @escaping (_ data : Any? ,_ error : String?) -> Void,user : UserModel?){
        db.collection(FirebaseCollections.Users.rawValue).document(user!.uid!)
            .setData([
            "uid" : user!.uid!,
            "userName" : user?.userName ?? "",
            "email" : user?.email ?? "",
            "password" : user?.password ?? "",
            "mobileNumber" : user?.mobileNumber ?? "",
            "address" : []
            
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
    //MARK: - ADD User Address Method
    func addUserAddress(completion  :@escaping (_ data : Any? ,_ error : String?) -> Void , address  : AddressModel){
        guard let uid = auth.currentUser?.uid else{
            completion(nil , ErrorStrings.authError)
            return
        }
        let finalAddress : [String : String] = [
            "id" : UUID().uuidString,
            "title" : address.title,
            "street" : address.street,
            "district" : address.district,
            "governrate" : address.governrate,
            "moreDetails" : address.moreDetails
           
        ]
        if address.id == "" {
            address.id = finalAddress["id"]!
        }
        db.collection(FirebaseCollections.Users.rawValue).document(uid).setData([
            "address" :[
                address.id : finalAddress
                ]
            ], merge : true)
        completion(AppStrings.success ,nil)
    
    }
    //MARK: - GET User Address Method
    func getUserAddress(completion  :@escaping (_ data : [AddressModel]? ,_ error : String?) -> Void ){
        guard let uid = auth.currentUser?.uid else{
            completion(nil , ErrorStrings.authError)
            return
        }
        var addressArr : [AddressModel] = []
        db.collection(FirebaseCollections.Users.rawValue)
            .document(uid).getDocument(completion:  { document, error in
                if let document = document {
                    if  let cart  = document.data()!["address"] as? [String : Any]{
                        for (_ , value) in cart {
                            let address = AddressModel(_data: value as! NSDictionary)
                            addressArr.append(address)
                        }
                        completion(addressArr,nil)
                    }
                }else{
                    completion(nil , error?.localizedDescription)
                }

            })
    }
    //MARK: - ADD Category Method
    func addCategory(completion  :@escaping (_ data : CategoryModel? ,_ error : String?) -> Void , category  : CategoryModel ){
        let categoryId = UUID().uuidString
        db.collection(FirebaseCollections.Category.rawValue).document(categoryId).setData([
            "id" : categoryId,
            "name" : category.name ?? "",
        ])
    }
    //MARK: - GET Categories Method
    func getCategories(completion  :@escaping (_ data : [CategoryModel]? ,_ error : String?) -> Void ){
        var categories : [CategoryModel] = []
        db.collection(FirebaseCollections.Category.rawValue)
            .getDocuments(completion:  { querySnapShot, error in
                if querySnapShot != nil {
                    if !querySnapShot!.isEmpty{
                        for category in querySnapShot!.documents {
                            let finalCategory = CategoryModel(_data: category.data() as NSDictionary)
                            categories.append(finalCategory)
                        }
                    }else{
                        completion(nil , ErrorStrings.noData)
                    }
                }else{
                    completion(nil , error?.localizedDescription)
                }
                completion(categories , nil)
            })
    }
    
    //MARK: - ADD Product Method
    func addProduct(completion  :@escaping (_ data : Any? ,_ error : String?) -> Void , product  : ProductModel ){
        let productId = UUID().uuidString
        db.collection(FirebaseCollections.Product.rawValue).document(productId).setData([
            "id" : productId,
            "name" : product.name ?? "",
            "category" : product.category ?? "",
            "image": product.image ?? "",
            "price" : product.price ?? "",
            "quantity" : product.quantity ?? 0,
            "size" : product.sizes ?? [],
            "rate" : product.rate ?? 0
        ]as [String : Any]) { err in
            if err != nil {
                completion(nil , err?.localizedDescription)
            }
        }
        completion(AppStrings.success ,nil)
    }
    //MARK: - GET Products Method
    func getProducts(completion  :@escaping (_ data : [ProductModel]? ,_ error : String?) -> Void ){
        var products : [ProductModel] = []
        db.collection(FirebaseCollections.Product.rawValue)
            .getDocuments(completion:  { querySnapShot, error in
                if querySnapShot != nil {
                    if !querySnapShot!.isEmpty{
                        for product in querySnapShot!.documents {
                            let finalProduct = ProductModel(_data: product.data() as NSDictionary)
                            products.append(finalProduct)
                        }
                    }else{
                        completion(nil , ErrorStrings.noData)
                    }
                }else{
                    completion(nil , error?.localizedDescription)
                }
                completion(products , nil)
            })
    }
    //MARK: - ADD To Product Cart Method
    func addToCart(completion  :@escaping (_ data : Any? ,_ error : String?) -> Void , quantity : Int ,product  : ProductModel ){
        guard let uid = auth.currentUser?.uid else{
            completion(nil , ErrorStrings.authError)
            return
        }
        let finalProduct : [String : Any] = [
            "id" : product.id ?? "",
            "name" : product.name ?? "",
            "category" : product.category ?? "",
            "image": product.image ?? "",
            "price" : product.price ?? "",
            "quantity" : product.quantity ?? 0,
            "size" : product.sizes ?? [],
            "rate" : product.rate ?? 0
        ]
        db.collection(FirebaseCollections.Users.rawValue).document(uid).setData([
            "cart" :[
                product.id : [
                    "product" : finalProduct,
                    "quantity" : quantity
                    ]
                ]
            ], merge : true)
        completion(AppStrings.success ,nil)
    
    }
    //MARK: - GET Cart Products Method
    func getCartProducts(completion  :@escaping (_ data : [CartModel]? ,_ error : String?) -> Void ){
        guard let uid = auth.currentUser?.uid else{
            completion(nil , ErrorStrings.authError)
            return
        }
        var cartArr : [CartModel] = []
        db.collection(FirebaseCollections.Users.rawValue)
            .document(uid).getDocument(completion:  { document, error in
                if let document = document {
                    if  let cart  = document.data()!["cart"] as? [String : Any]{
                        for (_ , value) in cart {
                            let cartProd = CartModel(_data: value as! NSDictionary)
                            cartArr.append(cartProd)
                        }
                        completion(cartArr,nil)
                    }
                }else{
                    completion(nil , error?.localizedDescription)
                }

            })
    }

    //MARK: - DELETE Product From Cart Method
    func deleteProductFromCart(completion : @escaping (_ data : Any? ,_ error : String?) -> Void , id : String?) {
        guard let uid = auth.currentUser?.uid else{
            completion(nil , ErrorStrings.authError)
            return
        }
        db.collection(FirebaseCollections.Users.rawValue)
            .document(uid).setData([
                "cart" : [
                    id : FieldValue.delete()
                ]
                   ], merge: true) {err in
                       if let error = err {
                           completion(nil, error.localizedDescription)
                       }else{
                           completion(AppStrings.productDeletedSuccesfully , nil)
                       }
                   }
     
    }
    //MARK: - GET Coupon Method
    func getCoupon(completion : @escaping (_ data : CouponModel? ,_ error : String?) -> Void, couponCode : String){
        db.collection(FirebaseCollections.Coupons.rawValue).getDocuments(completion: { querySnapshot, error in
            if error == nil {
                if let snapShot = querySnapshot {
                    let doc = snapShot.documents
                    for item in doc{
                        if item["code"] as! String == couponCode {
                            let data = CouponModel(_data: item.data() as NSDictionary)
                            completion(data,nil)
                        }
                    }
                }else{
                    completion(nil , ErrorStrings.invalidCouponCodeError)
            }
        }else{
            completion(nil , error?.localizedDescription)
        }
    }
 )}
    //MARK: - ADD To Wishlist Method
    func addToWishlist(completion  :@escaping (_ data : Any? ,_ error : String?) -> Void , product  : ProductModel ){
        guard let uid = auth.currentUser?.uid else{
            completion(nil , ErrorStrings.authError)
            return
        }
        let finalProduct : [String : Any] = [
            "id" : product.id ?? "",
            "name" : product.name ?? "",
            "category" : product.category ?? "",
            "image": product.image ?? "",
            "price" : product.price ?? "",
            "quantity" : product.quantity ?? 0,
            "size" : product.sizes ?? [],
            "rate" : product.rate ?? 0
        ]
        db.collection(FirebaseCollections.Users.rawValue).document(uid).setData([
            "wishlist" :[
                product.id : finalProduct
                ]
            ], merge : true)
        completion(AppStrings.success ,nil)
    
    }
                                                                        
    //MARK: - GET WishList Products Method
    func getUserWishLishProducts(completion  :@escaping (_ data : [ProductModel]? ,_ error : String?) -> Void ){
        guard let uid = auth.currentUser?.uid else{
            completion(nil , ErrorStrings.authError)
            return
        }
        var wishlistArr : [ProductModel] = []
        db.collection(FirebaseCollections.Users.rawValue)
            .document(uid).getDocument(completion:  { document, error in
                if let document = document {
                    if  let wishlist  = document.data()!["wishlist"] as? [String : Any]{
                        for (_ , value) in wishlist {
                            let wishlistProduct = ProductModel(_data: value as! NSDictionary)
                            wishlistArr.append(wishlistProduct)
                        }
                        completion(wishlistArr,nil)
                    }
                }else{
                    completion(nil , error?.localizedDescription)
                }

            })
    }
    //MARK: - ADD To Order Method
    func addOrder(completion  :@escaping (_ data : Any? ,_ error : String?) -> Void , products  : [CartModel] ,total : Double ){
        guard let uid = auth.currentUser?.uid else{
            completion(nil , ErrorStrings.authError)
            return
        }
        var cartProducts : [Any]  = []
        let orderId = UUID().uuidString
        var ordersIds : [String] = []
        for item in products {
            let finalProduct : [String : Any] = [
                "id" : item.product?.id ?? "",
                "name" : item.product?.name ?? "",
                "category" : item.product?.category ?? "",
                "image": item.product?.image ?? "",
                "price" : item.product?.price ?? "",
                "quantity" : item.product?.quantity ?? 0,
                "size" : item.product?.sizes ?? [],
                "rate" : item.product?.rate ?? 0
            ]
            cartProducts.append(finalProduct)
        }
        
        db.collection(FirebaseCollections.Order.rawValue).document(orderId).setData([
            "id" : orderId,
            "timestamp" : Timestamp().seconds,
            "products" : cartProducts,
            "status" : "Proccessing",
            "total" : total
            
        ])
        db.collection(FirebaseCollections.Users.rawValue).document(uid).getDocument { doc, err in
            if let data = doc?.data() {
                ordersIds = data["orders"] as! Array<String>
                ordersIds.append(orderId)
                self.db.collection(FirebaseCollections.Users.rawValue).document(uid).setData([
                    "orders" :ordersIds,
                    "cart" : [:]
                    ], merge : true)
            }
        }
      
        completion(AppStrings.success ,nil)
    
    }
    //MARK: - GET Orders Method
    func getOrders(completion : @escaping (_ data : [OrderModel]?,_ error : String?)-> Void ){
        var orders : [OrderModel] = []
        guard let uid = auth.currentUser?.uid else{
            completion(nil , ErrorStrings.authError)
            return
        }
        db.collection(FirebaseCollections.Users.rawValue).document(uid).getDocument { doc, error in
            if let document = doc {
                guard let ids = document["orders"] as? Array<String> else{
                    completion(nil , ErrorStrings.noData)
                    return
                }
                if ids.count > 0 {
                    for id in ids {
                        self.db.collection(FirebaseCollections.Order.rawValue).document(id).getDocument { doc, error in
                            guard let data = doc?.data() else{
                                completion(nil , ErrorStrings.noData)
                                return
                            }
                            orders.append(OrderModel(_data: data as NSDictionary))
                            completion(orders , nil)
                         
                        }
                    }

                    }
            }
       
        }
    }
}
