//
//  PhoneNumberViewController.swift
//  freetone
//
//  Created by Mac on 24/11/2024.
//

import UIKit
import ContactsUI
import Contacts

// MARK: - UI -
class DialerViewController: UIViewController {
    
    // MARK: - Objects -
    var phoneNumberLabel: UILabel!
    var digitButtons: [UIButton] = []
    let digits = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "*","0", "#"]
    
    var lastPressTime: Date?
    let doublePressTime: TimeInterval = 0.3
    
    //MARK: - Create a custom view for the navigation bar -
    fileprivate lazy var customView: UIView = {
        let customView = UIView()
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.backgroundColor = .darkGray
        navigationItem.titleView = customView
        view.addSubview(customView)
        return customView
    }()
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPhoneNumberLabel()
        setupDialerButtons()
        setupActionButtons()
    }
    
    // MARK: - Customizing the label and setting the constraint -
    func setupPhoneNumberLabel() {
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
            customView.topAnchor.constraint(equalTo: view.topAnchor),
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            phoneNumberLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            phoneNumberLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            phoneNumberLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - Customizing the buttons and setting the constraint -
    func setupDialerButtons() {
        let rows = 3
        let columns = 3
        let buttonSize: CGFloat = 70
        
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
                btn.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 50 + CGFloat(row) * (buttonSize + 10)),
                btn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(column) * (buttonSize + 45) + 45)
            ])
        }
    }
    
    // MARK: - Customizing the call and delete, setting the constraint -
    func setupActionButtons() {
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
    @objc func digitButtonTapped(_ sender: UIButton) {
        guard let digit = sender.title(for: .normal) else {return}
        phoneNumberLabel.text = (phoneNumberLabel?.text ?? "") + digit
        let currentTime = Date()
        
        if let lastTime = lastPressTime,
           currentTime.timeIntervalSince(lastTime) < doublePressTime {
            switch digit {
            case "2":
                phoneNumberLabel.text = (phoneNumberLabel.text ?? "") + "A"
            case "3":
                phoneNumberLabel.text = (phoneNumberLabel.text ?? "") + "B"
            case "4":
                phoneNumberLabel.text = (phoneNumberLabel.text ?? "") + "C"
            case "5":
                phoneNumberLabel.text = (phoneNumberLabel.text ?? "") + "D"
            case "6":
                phoneNumberLabel.text = (phoneNumberLabel.text ?? "") + "E"
            case "7":
                phoneNumberLabel.text = (phoneNumberLabel.text ?? "") + "F"
            case "8":
                phoneNumberLabel.text = (phoneNumberLabel.text ?? "") + "G"
            case "9":
                phoneNumberLabel.text = (phoneNumberLabel.text ?? "") + "H"
            case "0":
                phoneNumberLabel.text = (phoneNumberLabel.text ?? "") + "+"
            case "*":
                phoneNumberLabel.text = (phoneNumberLabel.text ?? "") + "I"
            case "#":
                phoneNumberLabel.text = (phoneNumberLabel.text ?? "") + "J"
            default:
                phoneNumberLabel.text = (phoneNumberLabel.text ?? "")
            }
        } else {
            phoneNumberLabel.text = (phoneNumberLabel.text ?? "")
        }
        lastPressTime = currentTime
    }
    
    // MARK: -
    @objc func callButtonTapped() {
        print("")
    }
    
    // MARK: - Method that deletes the button text from the label -
    @objc func deleteButtonTapped() {
        phoneNumberLabel.text = String(phoneNumberLabel.text?.dropLast() ?? "")
    }
}
