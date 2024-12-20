//
//  TextField.swift
//  freetone
//
//  Created by Mac on 24/11/2024.
//

import UIKit

// MARK: - ReusableObject -
class TextField: UITextField {
    
    // MARK: - Object property and value initialization -
    init(placeholder: String, isSecureTextEntry: Bool, radius: CGFloat, background: UIColor) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont(name: "", size: 18)
        textColor = UIColor(red: 0/255, green: 255/255, blue: 230/255, alpha: 1.0)
        backgroundColor = background
        layer.cornerRadius = radius
        autocapitalizationType = .none
        autocorrectionType = .no
        self.placeholder = placeholder
        self.isSecureTextEntry = isSecureTextEntry
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
