//
//  Extensions.swift
//  freetone
//
//  Created by Mac on 02/12/2024.
//

import Foundation
import UIKit

extension String {
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        let passwordRegEx = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`']{6,}$"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: self)
    }
}

//MARK: - Extension to get the parent viewcontroller -
extension UIView {
    var viewController: UIViewController? {
        var nextResponder = self.next
        while !(nextResponder is UIViewController) {
            nextResponder = nextResponder?.next
        }
        return nextResponder as? UIViewController
    }
}
