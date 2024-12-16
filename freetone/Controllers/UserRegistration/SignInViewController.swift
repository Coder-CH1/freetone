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
    let emailTextField = FloatingTextField(placeHolder: "Enter your valid email address", isSecureTextEntry: false, radius: 5, background: .clear, borderWidth: 2, borderColor: .red)
    
    ////TEXTFIELD
    let passwordTextField = FloatingTextField(placeHolder: "Create your password", isSecureTextEntry: true, radius: 5, background: .clear, borderWidth: 2, borderColor: .red)
    
    ////BUTTON
    let forgotPasswordBtn = Button(image: UIImage(), text: "Forgot your password?", btnTitleColor: UIColor(red: 0/255, green: 255/255, blue: 230/255, alpha: 1.0), backgroundColor: .clear, radius: 0, imageColor: .clear, borderWidth: 0, borderColor: UIColor.clear.cgColor)
    
    ////BUTTON
    let loginButton = Button(image: UIImage(), text: "Log in", btnTitleColor: .gray, backgroundColor: .darkGray, radius: 10, imageColor: .clear, borderWidth: 0, borderColor: UIColor.clear.cgColor)
    
    ////BUTTON
    let signupButton = Button(image: UIImage(), text: "Confirm your age", btnTitleColor: UIColor(red: 0/255, green: 255/255, blue: 230/255, alpha: 1.0), backgroundColor: .clear, radius: 0, imageColor: .clear, borderWidth: 0, borderColor: UIColor.clear.cgColor)
    
    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setSubviewsAndLayout()
        setupTextFieldListeners()
    }
    
    // MARK: - Subviews and Layout -
    func setSubviewsAndLayout() {
        let subViews = [titleLabel, emailTextField, passwordTextField, forgotPasswordBtn, loginButton, signupButton,togglePasswordVisibilityButton]
        for subView in subViews {
            view.addSubview(subView)
        }
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            forgotPasswordBtn.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            forgotPasswordBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            loginButton.topAnchor.constraint(equalTo: forgotPasswordBtn.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 55),
            
            signupButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 30),
            signupButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
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
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        
        loginButton.addTarget(self, action: #selector(loginUser), for: .touchUpInside)
        signupButton.addTarget(self, action: #selector(navigateToSignup), for: .touchUpInside)
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
        } else {
            loginButton.backgroundColor = .darkGray
        }
    }
    
    // MARK: - Method that logs in users, implementing singleton pattern design -
    @objc func loginUser() {
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
            await AuthManager.shared.checkSession()
            
            if AuthManager.shared.isLoggedIn {
                await AuthManager.shared.logout()
            }
            
            await AuthManager.shared.login()
            if AuthManager.shared.errorMessage.isEmpty {
                let vc = TabBarViewController()
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false)
            } else {
                let alert = UIAlertController(title: "Error", message: AuthManager.shared.errorMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(alert, animated: true)
            }
        }
    }
    
    //MARK: - Navigate to sign up screen -
    @objc func navigateToSignup() {
        let vc = ConfirmYourAgeViewController()
        
        let backItem = UIBarButtonItem()
        backItem.title = "Confirm your age"
        navigationItem.backBarButtonItem = backItem
        
        navigationController?.navigationBar.tintColor = .gray
        navigationController?.pushViewController(vc, animated: false)
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
