//
//  Alert.swift
//  Zodiec
//
//  Created by Ahmad Ellashy on 23/07/2023.
//

import UIKit
import FirebaseAuth
    
func handleErrorAlert(_ error : String ,controller : UIViewController ){

    let alert = UIAlertController(
                title: "An error occured",
                message: error,
                preferredStyle: .alert
            )
            
            alert.addAction(UIAlertAction(
                title: "Dismiss",
                style: .default
            ))

            alert.addAction(UIAlertAction(
                title: "Retry",
                style: .default,
                handler: { _ in
//                    self?.loadConversations()
                }
            ))
    controller.present(alert,animated: true)
    
    }

var alert : UIAlertController?
func loadingAlert(controller : UIViewController){
    alert = UIAlertController(
           title: "Loading...",
           message: nil,
           preferredStyle: .alert
       )
       
       let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
       loadingIndicator.hidesWhenStopped = true
       loadingIndicator.style = UIActivityIndicatorView.Style.medium
       loadingIndicator.startAnimating()
       
       if let alert = alert {
           alert.view.addSubview(loadingIndicator)
           controller.present(alert, animated: true, completion: nil)
       }
}
func dismissAlert() {
    if let presentingViewController = alert?.presentingViewController {
        presentingViewController.dismiss(animated: true, completion: nil)
    }
}

func dismissAlert(controller : UIViewController){
    controller.dismiss(animated: true, completion: nil)
}
func successAlert(message : String,controller : UIViewController){
    let alert = UIAlertController(
                title: "Success",
                message: message,
                preferredStyle: .alert
            )

            alert.addAction(UIAlertAction(
                title: "OK",
                style: .default
            ))
    controller.present(alert, animated: true)

}
