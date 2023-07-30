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

func loadingAlert(controller : UIViewController){
    let alert = UIAlertController(
                title: "Loading...",
                message: nil,
                preferredStyle: .alert
            )
    let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50)) as UIActivityIndicatorView
      loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
      loadingIndicator.startAnimating();
    
    alert.view.addSubview(loadingIndicator)
    controller.present(alert, animated: true, completion: nil)
}
