//
//  RegisterViewController.swift
//  Zodiec
//
//  Created by Ahmad Ellashy on 20/07/2023.
//

import UIKit

class RegisterViewController: UIViewController {
    //MARK: - IBOutLets
    @IBOutlet var GoogleButtonView : UIView!
    @IBOutlet var AppleButtonView : UIView!
    @IBOutlet var UserNameTextFieldView : UIView!
    @IBOutlet var EmailTextFieldView : UIView!
    @IBOutlet var PasswordTextFieldView : UIView!
    @IBOutlet var ConfirmPasswordTextFieldView : UIView!
    @IBOutlet var userNameTextField : UITextField!
    @IBOutlet var emailTextField : UITextField!
    @IBOutlet var passwordTextField : UITextField!
    @IBOutlet var confirmPasswordTextField : UITextField!
    @IBOutlet var SignUpButton : UIButton!
    @IBOutlet var userNameErrorLabel : UILabel!
    @IBOutlet var emailErrorLabel : UILabel!
    @IBOutlet var passwordErrorLabel : UILabel!
    @IBOutlet var confirmPasswordErrorLabel : UILabel!

    //MARK: - Properties
    var user : UserModel?
    var authApis : AuthApis = AuthApis()

    override func viewDidLoad() {
        super.viewDidLoad()
        SignUpButton.isEnabled = false

        setupTextFields()
        UserNameTextFieldView.addBorder()
        EmailTextFieldView.addBorder()
        PasswordTextFieldView.addBorder()
        ConfirmPasswordTextFieldView.addBorder()
    
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(GoogleButtonViewPressed))
        self.GoogleButtonView.addGestureRecognizer(gesture)

        GoogleButtonView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 58)
    }

    
    //MARK: - FUNCTIONS

    @objc func GoogleButtonViewPressed(sender : UITapGestureRecognizer) {
        loadingAlert(controller: self)
        authApis.SignUpWithGoogle(completion: { data,error  in
            if error != nil {
                self.presentedViewController?.dismiss(animated: true, completion: {
                    handleErrorAlert(error!, controller: self)
                })

            }
            self.presentedViewController?.dismiss(animated: true, completion: nil)
        }, controller: self)
    }


    @IBAction func SignUpButtonPressed(_ sender: UIButton) {
        loadingAlert(controller: self)

        guard let userName = userNameTextField.text else {return}
        print(userName)
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        guard let confirmPassword = confirmPasswordTextField.text else {return}
        if password != confirmPassword {
                self.presentedViewController?.dismiss(animated: true, completion:{
                    handleErrorAlert(ErrorStrings.passwordDoesnotMath, controller: self)

                })
            
        }else{
        authApis.signUp(completion: { data , error in
            if error != nil {
                self.presentedViewController?.dismiss(animated: true, completion: {
                    handleErrorAlert(error!, controller: self)
                })
            }else{
                self.performSegue(withIdentifier: SegueStrings.registerGoToHomeSegue, sender: nil)
            }
        },user: UserModel(uid: nil, userName: userName, email: email, mobileNumber: nil, password: password, imageUrl: nil, status: nil, token: nil, date: nil),viewController: self)
        }
    }
    
}//:UIViewController

//MARK: - TextFields Methods
extension RegisterViewController {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if userNameTextField.isValid() && emailTextField.isValid() && passwordTextField.isValid() && confirmPasswordTextField.isValid() {
            SignUpButton.isEnabled = true
        }else{
            SignUpButton.isEnabled = false
        }
    }
    
    func setupTextFields(){
        userNameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingDidEnd)
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingDidEnd)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingDidEnd)
        confirmPasswordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingDidEnd)
    }
  
}
