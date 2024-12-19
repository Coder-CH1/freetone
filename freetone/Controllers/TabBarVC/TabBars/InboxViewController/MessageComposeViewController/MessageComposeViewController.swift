//
//  MessagesComposeViewController.swift
//  freetone
//
//  Created by Mac on 02/12/2024.
//

import UIKit
import MessageUI
import ContactsUI

class MessageComposeViewController: BaseViewController {
    
    let contactButton = Button(image: UIImage(systemName: "person.crop.square"), text: "", btnTitleColor: .clear, backgroundColor: .clear, radius: 0, imageColor: .gray, borderWidth: 0, borderColor: UIColor.clear.cgColor)
    
    public lazy var phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter phone number"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .phonePad
        return textField
    }()
    
    fileprivate lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    fileprivate lazy var messageView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 8
        return textView
    }()
    
    let sendButton = Button(image: UIImage(systemName: ""), text: "Send message", btnTitleColor: UIColor(red: 0/255, green: 255/255, blue: 230/255, alpha: 1.0), backgroundColor: .clear, radius: 0, imageColor: .clear, borderWidth: 0, borderColor: UIColor.clear.cgColor)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSubviewsAndLayout()
    }
    
    // MARK: - Subviews and Layout -
    func setSubviewsAndLayout() {
        let subViews = [contactButton, phoneNumberTextField, messageView, sendButton,  phoneNumberLabel]
        for subView in subViews {
            view.addSubview(subView)
        }
        NSLayoutConstraint.activate([
            contactButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            contactButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            phoneNumberTextField.topAnchor.constraint(equalTo: contactButton.bottomAnchor, constant: 20),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            phoneNumberLabel.topAnchor.constraint(equalTo: contactButton.bottomAnchor, constant: 20),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            phoneNumberLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            messageView.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 100),
            messageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            messageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            messageView.heightAnchor.constraint(equalToConstant: 150),
            
            sendButton.topAnchor.constraint(equalTo: messageView.bottomAnchor, constant: 20),
            sendButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        contactButton.addTarget(self, action: #selector(contactButtonTapped), for: .touchUpInside)
        sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        
        messageView.delegate = self
        //phoneNumberLabel.isHidden = true
    }
    
    //MARK: - Method that opens the contact picker viewcontroller -
    @objc override func contactButtonTapped() {
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = self
        present(contactPicker, animated: true)
    }
    
    @objc func sendMessage() {
        guard let phoneNumber = phoneNumberTextField.text, !phoneNumber.isEmpty,
              let messageBody = messageView.text, !messageBody.isEmpty else {
            showAlert(title: "Error", message: "Please enter both phone number and message")
            return
        }
        
        if MFMessageComposeViewController.canSendText() {
            let messageController = MFMessageComposeViewController()
            messageController.body = messageBody
            messageController.recipients = [phoneNumber]
            messageController.messageComposeDelegate = self
            present(messageController, animated: true)
        } else {
            showAlert(title: "Error", message: "SMS is not available on this device")
        }
    }
}

extension MessageComposeViewController: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true)
        switch result {
        case .sent:
            print("message sent successfully")
        case .failed:
            print("message sending failed")
        case .cancelled:
            print("message sending cancelled")
        default:
            break
        }
    }
}

extension MessageComposeViewController: CNContactPickerDelegate {
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        if let phoneNumber = contact.phoneNumbers.first?.value.stringValue {
            phoneNumberTextField.text = phoneNumber
        }
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        print("")
    }
}

extension MessageComposeViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if !phoneNumberTextField.isHidden {
            phoneNumberTextField.isHidden = true
            
            if let phoneNumber = phoneNumberTextField.text, !phoneNumber.isEmpty {
                phoneNumberLabel.text = "To:  \(phoneNumber)"
                phoneNumberLabel.isHidden = false
            }
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            phoneNumberLabel.isHidden = true
            phoneNumberTextField.isHidden = false
        }
    }
}
