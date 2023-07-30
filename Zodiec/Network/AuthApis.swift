//
//  AuthApis.swift
//  Zodiec
//
//  Created by Ahmad Ellashy on 22/07/2023.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import GoogleSignIn
import UIKit
class AuthApis {
    let auth =  Auth.auth()
    let apiMananger : ApiManager = ApiManager()
    
    //MARK: - SIGN UP METHOD
    func signUp(completion : @escaping (_ data : Any? , _ error : String?) -> Void,user : UserModel, viewController : UIViewController){
        guard let email = user.email else { return }
        guard let password = user.password else{ return}
        auth.createUser(withEmail: email, password: password) { result, error in
            if result?.user != nil {
                let finalUser = UserModel(uid: result?.user.uid, userName: user.userName, email: email, mobileNumber: nil, password: password, imageUrl: nil, status: nil, token: nil, date: nil)
                self.apiMananger.addUser(completion:{_,err  in
                    completion(finalUser, nil)
                } , user: finalUser)
            }else{
                completion(nil , error!.localizedDescription)
            
            }
        }
    }
    //MARK: - SIGN UP WITH GOOGLE METHOD

    func SignUpWithGoogle(completion : @escaping (_ data : Any? , _ error : String?) -> Void,controller : UIViewController){
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: controller) { result, error in

          guard let user = result?.user,
            let idToken = user.idToken?.tokenString
          else {
              handleErrorAlert(error!.localizedDescription , controller: controller)
              return
                            
          }
              let credential : AuthCredential = GoogleAuthProvider
                .credential(withIDToken: idToken,
                            accessToken: user.accessToken.tokenString)
            self.auth.signIn(with: credential) { result, error in
                if error == nil {
                    self.apiMananger.addUser(completion: { data ,error  in
                        completion(data, nil)
                    }, user:  UserModel(uid: result?.user.uid, userName: result?.user.displayName, email: result?.user.email, mobileNumber: nil, password: nil, imageUrl: nil, status: nil, token: nil, date: nil))
                }else{
                    completion(nil , error?.localizedDescription)
                }
            }

           }
    }
    //MARK: - SIGN IN METHOD
    func signIn(completion : @escaping (_ data : Any? ,_ error : String?) -> Void,email : String , password : String, controller : UIViewController){
        auth.signIn(withEmail: email, password: password) { authResult, error in
            if error != nil{
                completion(nil , error!.localizedDescription)
            }else{
                completion(authResult , nil)

            }
            
        }
    }

    //MARK: - SIGN In WITH GOOGLE METHOD

    func SignInWithGoogle(completion : @escaping (_ data : UserModel? , _ error : String?) -> Void,controller : UIViewController){
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: controller) { result, error in

          guard let user = result?.user,
            let idToken = user.idToken?.tokenString
          else {
              handleErrorAlert(error!.localizedDescription , controller: controller)
              return
                            
          }
              let credential : AuthCredential = GoogleAuthProvider
                .credential(withIDToken: idToken,
                            accessToken: user.accessToken.tokenString)
            
            self.auth.signIn(with: credential) { result, error in
                if error == nil {
                    self.apiMananger.getUser(completion: { data, error in
                        
                        if data != nil {
                         completion(data,nil)
                        }
                    }, email: (result?.user.email)!)
                }else{
                    completion(nil , error?.localizedDescription)
                }
            }

           }
    }
}
