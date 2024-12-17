//
//  SignInViewController.swift
//  freetone
//
//  Created by Mac on 21/11/2024.
//

import UIKit
//MARK: - UI -
class SignInViewController: UIViewController {
    
    //MARK: - Objects -
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
    
    ////LABEL
    let titleLabel = Label(label: "Welcome back! \n\n Log in below.", textColor: .white, font: UIFont.systemFont(ofSize: 18, weight: .black))
    
    ////TEXTFIELD
    let emailTextField = FloatingTextField(placeHolder: "Enter your valid email address", isSecureTextEntry: false, radius: 5, background: .clear, borderWidth: 2, borderColor: .gray)
    
    ////TEXTFIELD
    let passwordTextField = FloatingTextField(placeHolder: "Create your password", isSecureTextEntry: true, radius: 5, background: .clear, borderWidth: 2, borderColor: .gray)
    
    ////BUTTON
    let forgotPasswordBtn = Button(image: UIImage(), text: "Forgot your password?", btnTitleColor: UIColor(red: 0/255, green: 255/255, blue: 230/255, alpha: 1.0), backgroundColor: .clear, radius: 0, imageColor: .clear, borderWidth: 0, borderColor: UIColor.clear.cgColor)
    
    ////BUTTON
    let loginButton = Button(image: UIImage(), text: "Log in", btnTitleColor: .gray, backgroundColor: .darkGray, radius: 10, imageColor: .clear, borderWidth: 0, borderColor: UIColor.clear.cgColor)
    
    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setSubviewsAndLayout()
        setupTextFieldListeners()
    }
    
    // MARK: - Subviews and Layout -
    func setSubviewsAndLayout() {
        let subViews = [titleLabel, emailTextField, passwordTextField, forgotPasswordBtn, loginButton, togglePasswordVisibilityButton]
        for subView in subViews {
            view.addSubview(subView)
        }
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            forgotPasswordBtn.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            forgotPasswordBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            loginButton.topAnchor.constraint(equalTo: forgotPasswordBtn.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            loginButton.heightAnchor.constraint(equalToConstant: 55),
            
            togglePasswordVisibilityButton.heightAnchor.constraint(equalToConstant: 20),
            togglePasswordVisibilityButton.widthAnchor.constraint(equalToConstant: 24),
            togglePasswordVisibilityButton.topAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: 20),
            togglePasswordVisibilityButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: -20),
        ])
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordBtn.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        loginButton.addTarget(self, action: #selector(loginUser), for: .touchUpInside)
        forgotPasswordBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
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
            loginButton.backgroundColor = UIColor(red: 0/255, green: 255/255, blue: 230/255, alpha: 1.0)
            loginButton.isEnabled = true
            loginButton.setTitleColor(UIColor.white, for: .normal)
            loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        } else {
            loginButton.backgroundColor = .darkGray
        }
    }
    
    // MARK: - Method that logs in users, implementing singleton pattern design -
    @objc func loginUser() {
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
            AlertManager.shared.showAlert(on: self, title: "Error", message: combinedMessage)
        }
        
        ////SET THE EMAIL AND PASSWORD
        AuthManager.shared.email = email
        AuthManager.shared.password = password
        
        Task {
            await AuthManager.shared.login()
            await AuthManager.shared.checkSession()
            
            if AuthManager.shared.isLoggedIn {
                UserDefaults.standard.set(AuthManager.shared.sessionToken, forKey: "sessionToken")
                
                DispatchQueue.main.async {
                    let vc = TabBarViewController()
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: false)
                    self.navigationController?.viewControllers.removeAll()
                }
            } else {
                AlertManager.shared.showAlert(on: self, title: "Error", message: AuthManager.shared.errorMessage)
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
