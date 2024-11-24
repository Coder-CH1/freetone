//
//  PhoneNumberPadView.swift
//  freetone
//
//  Created by Mac on 24/11/2024.
//

import UIKit
import Contacts

class PhoneNumberPadView: UIView, UITextFieldDelegate {
    var dialButtonTapHandler: ((String) -> Void)?
    
    //MARK: - Objects -
    let phoneNumberTextField = TextField(placeholder: "", isSecureTextEntry: false, radius: 0, background: .black)
    
    let btn1 = Button(image: UIImage(), text: "1", btnTitleColor: UIColor(red: 0/255, green: 255/255, blue: 230/255, alpha: 1.0), backgroundColor: .clear, radius: 0, imageColor: .clear, borderWidth: 0, borderColor: UIColor.clear.cgColor)
    
    let btn2 = Button(image: UIImage(), text: "2", btnTitleColor: UIColor(red: 0/255, green: 255/255, blue: 230/255, alpha: 1.0), backgroundColor: .clear, radius: 0, imageColor: .clear, borderWidth: 0, borderColor: UIColor.clear.cgColor)
    
    let btn3 = Button(image: UIImage(), text: "3", btnTitleColor: UIColor(red: 0/255, green: 255/255, blue: 230/255, alpha: 1.0), backgroundColor: .clear, radius: 0, imageColor: .clear, borderWidth: 0, borderColor: UIColor.clear.cgColor)
    
    let btn4 = Button(image: UIImage(), text: "4", btnTitleColor: UIColor(red: 0/255, green: 255/255, blue: 230/255, alpha: 1.0), backgroundColor: .clear, radius: 0, imageColor: .clear, borderWidth: 0, borderColor: UIColor.clear.cgColor)
    
    let btn5 = Button(image: UIImage(), text: "5", btnTitleColor: UIColor(red: 0/255, green: 255/255, blue: 230/255, alpha: 1.0), backgroundColor: .clear, radius: 0, imageColor: .clear, borderWidth: 0, borderColor: UIColor.clear.cgColor)
    
    let btn6 = Button(image: UIImage(), text: "6", btnTitleColor: UIColor(red: 0/255, green: 255/255, blue: 230/255, alpha: 1.0), backgroundColor: .clear, radius: 0, imageColor: .clear, borderWidth: 0, borderColor: UIColor.clear.cgColor)
    
    let btn7 = Button(image: UIImage(), text: "7", btnTitleColor:UIColor(red: 0/255, green: 255/255, blue: 230/255, alpha: 1.0), backgroundColor: .clear, radius: 0, imageColor: .clear, borderWidth: 0, borderColor: UIColor.clear.cgColor)
    
    let btn8 = Button(image: UIImage(), text: "8", btnTitleColor: UIColor(red: 0/255, green: 255/255, blue: 230/255, alpha: 1.0), backgroundColor: .clear, radius: 0, imageColor: .clear, borderWidth: 0, borderColor: UIColor.clear.cgColor)
    
    let btn9 = Button(image: UIImage(), text: "9", btnTitleColor: UIColor(red: 0/255, green: 255/255, blue: 230/255, alpha: 1.0), backgroundColor: .clear, radius: 0, imageColor: .clear, borderWidth: 0, borderColor: UIColor.clear.cgColor)
    
    let btn0 = Button(image: UIImage(), text: "0", btnTitleColor: UIColor(red: 0/255, green: 255/255, blue: 230/255, alpha: 1.0), backgroundColor: .clear, radius: 0, imageColor: .clear, borderWidth: 0, borderColor: UIColor.clear.cgColor)
    
    let btnStar = Button(image: UIImage(), text: "*", btnTitleColor: UIColor(red: 0/255, green: 255/255, blue: 230/255, alpha: 1.0), backgroundColor: .clear, radius: 0, imageColor: .clear, borderWidth: 0, borderColor: UIColor.clear.cgColor)
    
    let btnHash = Button(image: UIImage(), text: "#", btnTitleColor: UIColor(red: 0/255, green: 255/255, blue: 230/255, alpha: 1.0), backgroundColor: .clear, radius: 0, imageColor: .clear, borderWidth: 0, borderColor: UIColor.clear.cgColor)
    
    let btnCall = Button(image: UIImage(systemName: "phone.circle.fill"), text: "", btnTitleColor: .clear, backgroundColor: .clear, radius: 0, imageColor: .green, borderWidth: 0, borderColor: UIColor.clear.cgColor)
    
    let btnDelete = Button(image: UIImage(systemName: "delete.backward.fill"), text: "", btnTitleColor: .clear, backgroundColor: .clear, radius: 0, imageColor: .gray, borderWidth: 0, borderColor: UIColor.clear.cgColor)
    
    ////STACKVIEW
    fileprivate lazy var firstStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [btn1, btn2, btn3])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 80
        stack.alignment = .center
        stack.distribution = .fillProportionally
        return stack
    }()
    
    ////STACKVIEW
    fileprivate lazy var secondStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [btn4, btn5, btn6])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 80
        stack.alignment = .center
        return stack
    }()
    
    ////STACKVIEW
    fileprivate lazy var thirdStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [btn7, btn8, btn9])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 80
        stack.alignment = .center
        return stack
    }()
    
    ////STACKVIEW
    fileprivate lazy var fourthStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [btnStar, btn0, btnHash])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 80
        stack.alignment = .center
        return stack
    }()
    
    ////STACKVIEW
    fileprivate lazy var fifthStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [btnCall, btnDelete])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 10
        stack.alignment = .center
        return stack
    }()
    
    ////STACKVIEW
    fileprivate lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [firstStackView, secondStackView, thirdStackView, fourthStackView, fifthStackView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = -250
        stack.alignment = .center
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupLayout()
        setupAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Subviews and Layout -
    private func setupLayout() {
        addSubview(stackView)
        addSubview(phoneNumberTextField)
        NSLayoutConstraint.activate([
            phoneNumberTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 50),
            
            stackView.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: -120),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        phoneNumberTextField.delegate = self
    }
    
    // MARK: -
    private func setupAction() {
        let buttons: [Button] = [btn1, btn2, btn3, btn4, btn5, btn6, btn7, btn8, btn9, btn0, btnStar, btnHash, btnCall, btnDelete]
        
        for button in buttons {
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
//            button.heightAnchor.constraint(equalToConstant: 80).isActive = true
//            button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        }
        btnCall.addTarget(self, action: #selector(callButtonTapped), for: .touchUpInside)
    }
    
    // MARK: -
    @objc func buttonTapped(_ sender: Button) {
        guard let title = sender.titleLabel?.text else { return }
        phoneNumberTextField.text = phoneNumberTextField.text ?? "" + title
        dialButtonTapHandler?(title)
    }
    
    // MARK: -
    @objc func callButtonTapped() {
        dialButtonTapHandler?("Call")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "" {
            if let text = textField.text, !text.isEmpty {
                textField.text?.removeLast()
            }
            return false
        }
        return true
    }
}
