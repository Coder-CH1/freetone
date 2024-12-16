//
//  TextField.swift
//  freetone
//
//  Created by Mac on 22/11/2024.
//

import UIKit

// MARK: - ReusableObject -
class FloatingTextField: UIView {
    
    // MARK: - Objects properties -
    var textField: UITextField!
    var floatingLabel: UILabel!
    var isFloatingLabelVisible = false
    
    // MARK: - Object property and value initialization -
    init(placeHolder: String, isSecureTextEntry: Bool, radius: CGFloat, background: UIColor, borderWidth: Int, borderColor: UIColor) {
        super.init(frame: .zero)
        
        // MARK: - Set up textfield -
        textField = UITextField()
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "", size: 16)
        textField.textColor = .white
        textField.backgroundColor = background
        textField.layer.cornerRadius = radius
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = isSecureTextEntry
        textField.delegate = self
        
        textField.layer.borderWidth = CGFloat(borderWidth)
        textField.layer.borderColor = borderColor.cgColor
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 10)
        
        let textFieldHeight = CGFloat(55) + CGFloat(borderWidth + 2)
        
        // MARK: - Set up floatingLabel -
        floatingLabel = UILabel()
        floatingLabel.translatesAutoresizingMaskIntoConstraints = false
        floatingLabel.text = placeHolder
        floatingLabel.textColor = .lightGray
        floatingLabel.font = UIFont.systemFont(ofSize: 14)
        
        // MARK: - Adding textfield and floatingLabel to the view -
        addSubview(textField)
        addSubview(floatingLabel)
        
        // MARK: - Constraint for textfield and floatingLabel -
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            
            floatingLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            floatingLabel.centerXAnchor.constraint(equalTo: textField.centerXAnchor),
            floatingLabel.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
        ])
        updateFloatingLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    func updateFloatingLabel() {
        if let text = textField.text, !text.isEmpty || textField.isEditing {
            showFloatingLabel()
        } else {
            hideFloatingLabel()
        }
    }
    
    // MARK: -
    func showFloatingLabel() {
        if !isFloatingLabelVisible {
            UIView.animate(withDuration: 0.3) {
                self.floatingLabel.alpha = 1
                self.floatingLabel.transform = CGAffineTransform(translationX: 0, y: -25)
            }
            isFloatingLabelVisible = true
        }
    }
    
    // MARK: -
    func hideFloatingLabel() {
        if isFloatingLabelVisible {
            UIView.animate(withDuration: 0.3) {
                self.floatingLabel.alpha = 0
                self.floatingLabel.transform = .identity
            }
            isFloatingLabelVisible = false
        }
    }
}

// MARK: - UITextFieldDelegate Implementation -
extension FloatingTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        updateFloatingLabel()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateFloatingLabel()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        updateFloatingLabel()
        return true
    }
}

