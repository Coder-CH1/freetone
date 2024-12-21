//
//  NewConversationViewController.swift
//  freetone
//
//  Created by Mac on 02/12/2024.
//

import UIKit
import ContactsUI

//MARK: - UI -
class NewConversationViewController: BaseViewController {
    //MARK: - Objects -
    let label = Label(label: "To:", textColor: UIColor(red: 0/255, green: 255/255, blue: 230/255, alpha: 1.0), font: UIFont.systemFont(ofSize: 12, weight: .bold))
    
    let textField = TextField(placeholder: "Name, Phone or Username", isSecureTextEntry: false, radius: 0, background: .clear)
    
    let contactBtn = Button(image: UIImage(systemName: "circle.hexagongrid.fill"), text: "", btnTitleColor: .clear, backgroundColor: .clear, radius: 0, imageColor: .lightGray, borderWidth: 0, borderColor: UIColor.clear.cgColor)
    
    ////STACKVIEW
    fileprivate lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [label, textField, contactBtn])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 15
        stack.alignment = .center
        return stack
    }()
    
    //MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setSubviewsAndLayout()
    }
    
    //MARK: - Lifecycle -
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.text = ""
    }
    
    // MARK: - Subviews and Layout -
    func setSubviewsAndLayout() {
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            textField.heightAnchor.constraint(equalToConstant: 50),
            textField.widthAnchor.constraint(equalToConstant: 250)
        ])
        textField.delegate = self
        textField.addTarget(self, action: #selector(phoneNumberDidChange), for: .editingChanged)
        contactBtn.addTarget(self, action: #selector(contactButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - Method that opens the contact picker viewcontroller -
    @objc override func contactButtonTapped() {
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = self
        present(contactPicker, animated: true)
    }
    
    //MARK: - No transition needed, transition is handled in textFieldShouldReturn protocol delegate -
    @objc func phoneNumberDidChange() {
    }
    
    //MARK: -
    func presentToMessageComposeVC(withPhoneNumber phoneNumber: String) {
        let vc = MessageComposeViewController()
        vc.phoneNumberTextField.text = phoneNumber
        if let navVc = navigationController {
            navVc.pushViewController(vc, animated: false)
        } else {
            present(vc, animated: false)
        }
    }
}

//MARK: -
extension NewConversationViewController: CNContactPickerDelegate {
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        if let phoneNumber = contact.phoneNumbers.first?.value.stringValue {
            textField.text = phoneNumber
        }
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        print("")
    }
}

//MARK: - Protocol delegates that handles when the user presses the returns key on the keyboard -
extension NewConversationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let phoneNumber = textField.text, !phoneNumber.isEmpty {
            presentToMessageComposeVC(withPhoneNumber: phoneNumber)
        }
        return true
    }
}
