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
    let emailTextField = FloatingTextField(placeHolder: "Enter your valid email address", isSecureTextEntry: false, radius: 5, background: .clear, borderWidth: 2, borderColor: .red)
    
    ////TEXTFIELD
    let passwordTextField = FloatingTextField(placeHolder: "Create your password", isSecureTextEntry: true, radius: 5, background: .clear, borderWidth: 2, borderColor: .red)
    
    ////BUTTON
    let regButton = Button(image: UIImage(), text: "Start calling & texting", btnTitleColor: .gray, backgroundColor: .darkGray, radius: 10, imageColor: .clear, borderWidth: 0, borderColor: UIColor.clear.cgColor)
    
    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setSubviewsAndLayout()
        setupTextFieldListeners()
    }
    
    // MARK: - Subviews and Layout -
    func setSubviewsAndLayout() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(regButton)
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            emailTextField.widthAnchor.constraint(equalToConstant: 300),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.widthAnchor.constraint(equalToConstant: 300),
            
            regButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
            regButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            regButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            regButton.heightAnchor.constraint(equalToConstant: 55),
            regButton.widthAnchor.constraint(equalToConstant: 300)
        ])
        regButton.addTarget(self, action: #selector(registerUser), for: .touchUpInside)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Method to listens and changes the background color of the button -
    func setupTextFieldListeners() {
        emailTextField.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordTextField.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    // MARK: - Method for changing the background color of the button -
    @objc func textFieldDidChange() {
        if let emailText = emailTextField.textField.text, !emailText.isEmpty,
           let passwordText = passwordTextField.textField.text, !passwordText.isEmpty {
            regButton.backgroundColor = UIColor(red: 0/255, green: 255/255, blue: 230/255, alpha: 1.0)
            regButton.isEnabled = true
            regButton.setTitleColor(UIColor.white, for: .normal)
        } else {
            regButton.backgroundColor = .darkGray
            //loginButton.isEnabled = false
        }
    }
    
    // MARK: - Method that registers users, implementing singleton pattern design -
    @objc func registerUser() {
        AuthManager.shared.email = emailTextField.textField.text ?? ""
        AuthManager.shared.password = passwordTextField.textField.text ?? ""
        
        Task {
            await AuthManager.shared.register()
            if AuthManager.shared.errorMessage.isEmpty {
                let vc = TabBarViewController()
                present(vc, animated: false)
            } else {
                let alert = UIAlertController(title: "Error", message: AuthManager.shared.errorMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(alert, animated: true)
            }
        }
    }
}
