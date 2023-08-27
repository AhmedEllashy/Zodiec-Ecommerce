//
//  ViewController.swift
//  Zodiec
//
//  Created by Ahmad Ellashy on 19/07/2023.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet var emailTextFieldView : UIView!
    @IBOutlet var passwordTextFieldView : UIView!
    @IBOutlet var emailTextField : UITextField!
    @IBOutlet var passwordTextField : UITextField!
    @IBOutlet var GoogleButtonView : UIView!
    @IBOutlet var AppleButtonView : UIView!
    @IBOutlet var loginButton : UIButton!
    
    let authApis : AuthApis = AuthApis()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.isEnabled = false
        emailTextFieldView.RectangleBorderRadius()
        passwordTextFieldView.RectangleBorderRadius()
        setupTextFields()
        let gesture = UIGestureRecognizer(target: self, action: #selector(GoogleButtonViewPressed))
        self.GoogleButtonView.addGestureRecognizer(gesture)
        GoogleButtonView.isUserInteractionEnabled = true

    }
    
    
    
    
    
    
    //MARK: - FUNCTIONS
    @objc func GoogleButtonViewPressed(sender : UITapGestureRecognizer) {
        print("google pressed")
        authApis.SignInWithGoogle(completion: { data, error in
            loadingAlert(controller: self)
            if error != nil {
                self.presentedViewController?.dismiss(animated: true, completion: {
                    handleErrorAlert(error!, controller: self)
                })
            }else{
              
            }
        }, controller: self)
        
    }
    
    @IBAction func LoginButtonPressed(_ sender : UIButton) {
        loadingAlert(controller: self)
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else{return}
        authApis.signIn(completion: { data,error  in
            if error != nil {
                self.presentedViewController?.dismiss(animated: true, completion: {
                    handleErrorAlert(error!, controller: self)
                })
            }else{
                self.presentedViewController?.dismiss(animated: true, completion: nil)
                self.performSegue(withIdentifier: SegueStrings.loginGoToHomeSegue, sender: nil)
            }
        }, email: email, password: password, controller: self)
    }

}


//MARK: - TextFieldMethods
extension LoginViewController {
    @objc func textFieldDidEndEditing(_ textField : UITextField){
        if emailTextField.isValid() && passwordTextField.isValid() {
            loginButton.isEnabled = true
        }else{
            loginButton.isEnabled = false
        }
    }
    func setupTextFields(){
        emailTextField.addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)
    }
}



