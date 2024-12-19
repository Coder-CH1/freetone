//
//  NewConversationViewController.swift
//  freetone
//
//  Created by Mac on 02/12/2024.
//

import UIKit
import ContactsUI

class NewConversationViewController: BaseViewController {
    
    let label = Label(label: "To:", textColor: .lightGray, font: UIFont.systemFont(ofSize: 12, weight: .bold))
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        setSubviewsAndLayout()
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
        contactBtn.addTarget(self, action: #selector(contactButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - Method that opens the contact picker viewcontroller -
    @objc override func contactButtonTapped() {
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = self
        present(contactPicker, animated: true)
    }
}

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
