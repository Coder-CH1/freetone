//
//  Button.swift
//  freetone
//
//  Created by Mac on 21/11/2024.
//
import UIKit

// MARK: - ReusableObject -
class Button: UIButton {
    var text: String {
        didSet {
            setTitle(text, for: .normal)
        }
    }
    
    // MARK: - Object property and value initialization -
    init(image: UIImage?, text: String, btnTitleColor: UIColor, backgroundColor: UIColor, radius: CGFloat, imageColor: UIColor, borderWidth: Int, borderColor: CGColor) {
        self.text = text
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setImage(image, for: .normal)
        self.setTitle(text, for: .normal)
        self.setTitleColor(btnTitleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = radius
        self.tintColor = imageColor
        self.clipsToBounds = true
        self.isUserInteractionEnabled = true
        self.layer.borderWidth = CGFloat(borderWidth)
        self.layer.borderColor = borderColor
        
        if image == nil {
            self.imageView?.isHidden = true
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
