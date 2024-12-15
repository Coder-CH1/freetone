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
    
    ////UIBUTTON
    fileprivate var togglePasswordVisibilityButton: UIButton {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        let eyeIcon = UIImage(systemName: "eye.fill")
        btn.setImage(eyeIcon, for: .normal)
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        return btn
    }
    
    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setSubviewsAndLayout()
        setupTextFieldListeners()
    }
    
    //MARK: - Subviews and Layout -
    func setSubviewsAndLayout() {
        let subViews = [emailTextField, passwordTextField, regButton]
        for subView in subViews {
            view.addSubview(subView)
        }
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
        
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            regButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
            regButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            regButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            regButton.heightAnchor.constraint(equalToConstant: 55),
        ])
        regButton.addTarget(self, action: #selector(registerUser), for: .touchUpInside)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        passwordTextField.textField.rightView = togglePasswordVisibilityButton
        passwordTextField.textField.rightViewMode = .always
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
        let email = emailTextField.textField.text ?? ""
        let password = passwordTextField.textField.text ?? ""
        
        ////VALIDATE THAT BOTH EMAIL AND PASSWORD NON-EMPTY
        guard !email.isEmpty, !password.isEmpty else {
            let alert = UIAlertController(title: "Error", message: "Please enter both email and password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true)
            return
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
                let alert = UIAlertController(title: "Error", message: AuthManager.shared.errorMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(alert, animated: true)
            }
        }
    }
    
    //MARK: - Method to toggle the password visibility -
    @objc func togglePasswordVisibility() {
        passwordTextField.textField.isSecureTextEntry.toggle()
        
        let imgName = passwordTextField.textField.isSecureTextEntry ? "eye.fill" : "eye.slash.fill"
        togglePasswordVisibilityButton.setImage(UIImage(systemName: imgName), for: .normal)
    }
}
