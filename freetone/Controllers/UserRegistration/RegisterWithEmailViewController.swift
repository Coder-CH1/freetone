//
//  RegisterAccountViewController.swift
//  freetone
//
//  Created by Mac on 21/11/2024.
//

import UIKit
//MARK: - UI -
class RegisterWithEmailViewController: BaseViewController {
    
    //MARK: - Objects -
    ////TEXTFIELD
    let emailTextField = FloatingTextField(placeHolder: "Enter your valid email address", isSecureTextEntry: false, radius: 5, background: .clear, borderWidth: 2, borderColor: .gray)
    
    ////TEXTFIELD
    let passwordTextField = FloatingTextField(placeHolder: "Create your password", isSecureTextEntry: true, radius: 5, background: .clear, borderWidth: 2, borderColor: .gray)
    
    ////BUTTON
    let regButton = Button(image: UIImage(), text: "Start calling & texting", btnTitleColor: .gray, backgroundColor: .darkGray, radius: 10, imageColor: .clear, borderWidth: 0, borderColor: UIColor.clear.cgColor)
    
    ////BUTTON
    fileprivate lazy var togglePasswordVisibilityButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        let eyeIcon = UIImage(systemName: "eye.fill")
        btn.setImage(eyeIcon, for: .normal)
        btn.tintColor = .gray
        btn.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        return btn
    }()
    
    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setSubviewsAndLayout()
        setupTextFieldListeners()
    }
    
    //MARK: - Subviews and Layout -
    func setSubviewsAndLayout() {
        let subViews = [emailTextField, passwordTextField, regButton, togglePasswordVisibilityButton]
        for subView in subViews {
            view.addSubview(subView)
        }
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            regButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
            regButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            regButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            regButton.heightAnchor.constraint(equalToConstant: 55),
            
            togglePasswordVisibilityButton.heightAnchor.constraint(equalToConstant: 20),
            togglePasswordVisibilityButton.widthAnchor.constraint(equalToConstant: 24),
            togglePasswordVisibilityButton.topAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: 20),
            togglePasswordVisibilityButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: -20),
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
            regButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        } else {
            regButton.backgroundColor = .darkGray
        }
    }
    
    // MARK: - Method that registers users, implementing singleton pattern design -
    @objc func registerUser() {
        let email = emailTextField.textField.text ?? ""
        let password = passwordTextField.textField.text ?? ""
        
        var errorMessage = [String]()
        
        ////VALIDATE THAT BOTH EMAIL AND PASSWORD NON-EMPTY
        if !email.isValidEmail {
            errorMessage.append("Please enter a valid email address")
        }
        
        if !password.isValidPassword {
            errorMessage.append("Password must contain at least lowercase letter, one uppercase letter, one digit, and be at least 6 characters long")
        }
        
        if !errorMessage.isEmpty {
            let combinedMessage = errorMessage.joined(separator: "\n")
            showAlert(on: self, title: "Error", message: combinedMessage)
        }
        
        ////SET THE EMAIL AND PASSWORD
        AuthManager.shared.email = email
        AuthManager.shared.password = password
        
        Task {
            await AuthManager.shared.register()
            if AuthManager.shared.errorMessage.isEmpty {
                let vc = TabBarViewController()
                present(vc, animated: false)
            } else {
                showAlert(on: self, title: "Error", message: AuthManager.shared.errorMessage)
            }
        }
    }
    
    //MARK: - Method to toggle the visibility of the password -
    @objc func togglePasswordVisibility() {
        passwordTextField.textField.isSecureTextEntry.toggle()
        
        let imgName = passwordTextField.textField.isSecureTextEntry ? "eye.fill" : "eye.slash.fill"
        togglePasswordVisibilityButton.setImage(UIImage(systemName: imgName), for: .normal)
        
        UIView.animate(withDuration: 0.2) {
            self.passwordTextField.textField.layoutIfNeeded()
        }
    }
}
