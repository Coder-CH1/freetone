//
//  TextField.swift
//  freetone
//
//  Created by Mac on 22/11/2024.
//

import UIKit

// MARK: - ReusableObject -
class FloatingTextField: UIView {
    
    var textField: UITextField!
    var floatingLabel: UILabel!
    
    var placeHolder: String
    var isSecureTextEntry: Bool
    var radius: CGFloat
    var background: UIColor
    var borderWidth: Int
    var borderColor: UIColor
    
    init(placeHolder: String, isSecureTextEntry: Bool, radius: CGFloat, background: UIColor, borderWidth: Int, borderColor: UIColor) {
        self.placeHolder = placeHolder
        self.isSecureTextEntry = isSecureTextEntry
        self.radius = radius
        self.background = background
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        super.init(frame: .zero)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "", size: 16)
        textField.textColor = .white
        textField.backgroundColor = background
        textField.layer.cornerRadius = radius
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = isSecureTextEntry
        textField.delegate = self
        addSubview(textField)
        
        floatingLabel = UILabel()
        floatingLabel.translatesAutoresizingMaskIntoConstraints = false
        floatingLabel.text = placeHolder
        floatingLabel.textColor = .lightGray
        floatingLabel.font = UIFont.systemFont(ofSize: 14)
        addSubview(floatingLabel)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            floatingLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            floatingLabel.topAnchor.constraint(equalTo: textField.topAnchor, constant: 0)
        ])
        textField.addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
        updateFloatingLabel()
    }

    @objc func editingDidBegin() {
        animateFloatingLabel(up: true)
    }
    
    @objc func editingDidEnd() {
        if textField.text?.isEmpty ?? true {
            
        }
    }
    
    func updateFloatingLabel() {
        if textField.text?.isEmpty ?? true {
            floatingLabel.transform = CGAffineTransform(translationX: 0, y: 0)
        } else {
            floatingLabel.transform = CGAffineTransform(translationX: 0, y: -24)
        }
    }
    
    func animateFloatingLabel(up: Bool) {
        let translation: CGFloat = up ? -24 : 0
        UIView.animate(withDuration: 0.3)  {
            self.floatingLabel.transform = CGAffineTransform(translationX: 0, y: translation)
        }
    }
}

extension FloatingTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        animateFloatingLabel(up: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.isEmpty ?? true {
            animateFloatingLabel(up: false)
        }
    }
}
