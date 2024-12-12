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
    ////UIImageView
    fileprivate lazy var appLogo: UIImageView = {
        let logo = UIImageView(image: UIImage(named: "logo"))
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.tintColor = UIColor(red: 0/255, green: 255/255, blue: 230/255, alpha: 1.0)
        logo.contentMode = .scaleAspectFit
        return logo
    }()
    
    ////LABEL
    fileprivate lazy var appLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "FreeTone"
        label.textColor = UIColor(red: 0/255, green: 255/255, blue: 230/255, alpha: 1.0)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    ////STACKVIEW
    fileprivate lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [appLogo, appLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = -80
        stack.alignment = .center
        return stack
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
    let signupButton = Button(image: UIImage(), text: "Sign up", btnTitleColor: UIColor(red: 0/255, green: 255/255, blue: 230/255, alpha: 1.0), backgroundColor: .clear, radius: 0, imageColor: .clear, borderWidth: 0, borderColor: UIColor.clear.cgColor)
    
    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setSubviewsAndLayout()
        setupTextFieldListeners()
    }
    
    // MARK: - Subviews and Layout -
    func setSubviewsAndLayout() {
        view.addSubview(stackView)
        view.addSubview(titleLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(forgotPasswordBtn)
        view.addSubview(loginButton)
        view.addSubview(signupButton)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            
            titleLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            emailTextField.widthAnchor.constraint(equalToConstant: 300),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.widthAnchor.constraint(equalToConstant: 300),
            
            forgotPasswordBtn.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            forgotPasswordBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            loginButton.topAnchor.constraint(equalTo: forgotPasswordBtn.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 55),
            loginButton.widthAnchor.constraint(equalToConstant: 300),
            
            signupButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 30),
            signupButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordBtn.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        
        loginButton.addTarget(self, action: #selector(loginUser), for: .touchUpInside)
        signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
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
            //loginButton.isEnabled = false
        }
    }
    
    // MARK: - Method that logs in users, implementing singleton pattern design -
    @objc func loginUser() {
        NetworkManager.shared.email = emailTextField.textField.text ?? ""
        NetworkManager.shared.password = passwordTextField.textField.text ?? ""
        
        Task {
            await NetworkManager.shared.login()
            if NetworkManager.shared.errorMessage.isEmpty {
                let vc = TabBarViewController()
                present(vc, animated: false)
            } else {
                let alert = UIAlertController(title: "Error", message: NetworkManager.shared.errorMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(alert, animated: true)
            }
        }
    }
    
    @objc func signupButtonTapped() {
        let vc = RegisterWithEmailViewController()
        navigationController?.pushViewController(vc, animated: false)
    }
}
