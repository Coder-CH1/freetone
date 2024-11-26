//
//  PhoneNumberViewController.swift
//  freetone
//
//  Created by Mac on 24/11/2024.
//

import UIKit
import Contacts

// MARK: - UI -
class DialerViewController: UIViewController {
    
    // MARK: - Objects -
    private var phoneNumberLabel: UILabel!
    private var digitButtons: [UIButton] = []
    private let digits = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "*","0", "#"]
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPhoneNumberLabel()
        setupDialerButtons()
        setupActionButtons()
    }
    
    // MARK: - Customizing the label and setting the constraint -
    private func setupPhoneNumberLabel() {
        phoneNumberLabel = UILabel()
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberLabel.text = ""
        phoneNumberLabel.font = UIFont.systemFont(ofSize: 32, weight: .medium)
        phoneNumberLabel.textColor = .white
        phoneNumberLabel.textAlignment = .right
        phoneNumberLabel.numberOfLines = 0
        phoneNumberLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(phoneNumberLabel)
        
        NSLayoutConstraint.activate([
            phoneNumberLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            phoneNumberLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            phoneNumberLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - Customizing the buttons and setting the constraint -
    private func setupDialerButtons() {
        let rows = 3
        let columns = 3
        let buttonSize: CGFloat = 80
        
        for i in 0..<digits.count {
            let row = i / rows
            let column = i % columns
            
            let btn = UIButton(type: .system)
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setTitle(digits[i], for: .normal)
            btn.setTitleColor(UIColor(red: 0/255, green: 255/255, blue: 230/255, alpha: 1.0), for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 32)
            btn.addTarget(self, action: #selector(digitButtonTapped(_:)), for: .touchUpInside)
            
            digitButtons.append(btn)
            view.addSubview(btn)
            
            NSLayoutConstraint.activate([
                btn.widthAnchor.constraint(equalToConstant: buttonSize),
                btn.heightAnchor.constraint(equalToConstant: buttonSize),
                btn.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 20 + CGFloat(row) * (buttonSize + 20)),
                btn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(column) * (buttonSize + 35) + 35)
            ])
        }
    }
    
    // MARK: - Customizing the call and delete, setting the constraint -
    private func setupActionButtons() {
        let callBtn = UIButton(type: .system)
        callBtn.translatesAutoresizingMaskIntoConstraints = false
        callBtn.tintColor = .white
        callBtn.backgroundColor = .green
        callBtn.layer.cornerRadius = 40
        callBtn.setImage(UIImage(systemName: "phone.circle.fill"), for: .normal)
        callBtn.addTarget(self, action: #selector(callButtonTapped), for: .touchUpInside)
        
        let deleteBtn = UIButton(type: .system)
        deleteBtn.tintColor = .gray
        deleteBtn.translatesAutoresizingMaskIntoConstraints = false
        deleteBtn.setImage(UIImage(systemName: "delete.backward.fill"), for: .normal)
        deleteBtn.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        view.addSubview(callBtn)
        view.addSubview(deleteBtn)
        
        NSLayoutConstraint.activate([
            callBtn.widthAnchor.constraint(equalToConstant: 80),
            callBtn.heightAnchor.constraint(equalToConstant: 80),
            callBtn.topAnchor.constraint(equalTo: digitButtons[9].bottomAnchor, constant: 30),
            callBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            deleteBtn.widthAnchor.constraint(equalToConstant: 80),
            deleteBtn.heightAnchor.constraint(equalToConstant: 80),
            deleteBtn.topAnchor.constraint(equalTo: digitButtons[9].bottomAnchor, constant: 30),
            deleteBtn.leadingAnchor.constraint(equalTo: callBtn.trailingAnchor, constant: 20),
        ])
    }
    
    // MARK: - Method that shows the button text on the label when tapped -
    @objc private func digitButtonTapped(_ sender: UIButton) {
        guard let digit = sender.title(for: .normal) else {return}
        phoneNumberLabel.text = (phoneNumberLabel?.text ?? "") + digit
    }
    
    // MARK: -
    @objc private func callButtonTapped() {
        print("")
    }
    
    // MARK: - Method that deletes the button text from the label -
    @objc private func deleteButtonTapped() {
        phoneNumberLabel.text = String(phoneNumberLabel.text?.dropLast() ?? "")
    }    
}
