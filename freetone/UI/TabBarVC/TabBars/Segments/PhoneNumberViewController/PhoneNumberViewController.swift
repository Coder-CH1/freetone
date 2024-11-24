//
//  PhoneNumberViewController.swift
//  freetone
//
//  Created by Mac on 24/11/2024.
//

import UIKit
//MARK: - UI -
class PhoneNumberViewController: UIViewController {
    //MARK: - Objects -
    let phoneNumberTextField = TextField(placeholder: "", isSecureTextEntry: false, radius: 0, background: .lightGray)
    
    let phonePadView = PhoneNumberPadView()

    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setSubviewsAndLayout()
    }
    
    // MARK: - Subviews and Layout -
    func setSubviewsAndLayout() {
        view.addSubview(phonePadView)
        view.addSubview(phoneNumberTextField)
        NSLayoutConstraint.activate([
            phoneNumberTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 50),
            
            phonePadView.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 20),
            phonePadView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            phonePadView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            phonePadView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        phonePadView.translatesAutoresizingMaskIntoConstraints = false
        setupDialHandler()
    }
    
    private func setupDialHandler() {
        phonePadView.dialButtonTapHandler = { [weak self] buttonText in
            guard let self = self else { return }
            
            if buttonText == "call" {
                self.handleCallAction()
            } else if buttonText == "delete" {
                self.handleDeleteAction()
            } else {
                self.handleButtonTapped(number: buttonText)
            }
        }
    }
    
    private func handleButtonTapped(number: String) {
        phoneNumberTextField.text?.append(number)
    }
    
    private func handleCallAction() {
        if let phoneNumber = phoneNumberTextField.text, !phoneNumber.isEmpty {
           print("")
        } else {
            print("")
        }
    }
    
    private func handleDeleteAction() {
        if let text = phoneNumberTextField.text, !text.isEmpty {
            phoneNumberTextField.text?.removeLast()
        }
    }
}
