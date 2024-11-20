//
//  Label.swift
//  freetone
//
//  Created by Mac on 20/11/2024.
//

import UIKit

// MARK: - ReusableObject -
class Label: UILabel {
    
    // MARK: - Object propertie and value initialization -
    init(label: String, textColor: UIColor, font: UIFont) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.numberOfLines = 10
        self.text = label
        self.textColor = textColor
        self.lineBreakMode = .byWordWrapping
        self.clipsToBounds = true
        self.font = font
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

