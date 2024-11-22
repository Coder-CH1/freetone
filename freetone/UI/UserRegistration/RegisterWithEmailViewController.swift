//
//  RegisterAccountViewController.swift
//  freetone
//
//  Created by Mac on 21/11/2024.
//

import UIKit
//MARK: - UI -
class RegisterWithEmailViewController: UIViewController {
    
    //MARK: - Objects -
    ////TEXTFIELD
    let emailTextField = FloatingTextField(placeHolder: "email", isSecureTextEntry: false, radius: 5, background: .clear, borderWidth: 2, borderColor: .gray)
    
    ////TEXTFIELD
    let passwordTextField = FloatingTextField(placeHolder: "password", isSecureTextEntry: true, radius: 5, background: .clear, borderWidth: 2, borderColor: .gray)

    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setSubviewsAndLayout()
    }

    // MARK: - Subviews and Layout -
    func setSubviewsAndLayout() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            emailTextField.widthAnchor.constraint(equalToConstant: 300),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.widthAnchor.constraint(equalToConstant: 300),
        ])
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
    }
}
