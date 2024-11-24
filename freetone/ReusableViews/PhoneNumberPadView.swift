//
//  PhoneNumberPadView.swift
//  freetone
//
//  Created by Mac on 24/11/2024.
//

import UIKit
import Contacts

class PhoneNumberPadView: UIView {
    var dialButtonTapHandler: ((String) -> Void)?
    
    //MARK: -
    let btn1 = Button(image: UIImage(), text: "1", btnTitleColor: UIColor(red: 15/255, green: 15/255, blue: 15/255, alpha: 1.0), backgroundColor: .clear, radius: 0, imageColor: .clear, borderWidth: 0, borderColor: UIColor.clear.cgColor)
    
    let btn2 = Button(image: UIImage(), text: "2", btnTitleColor: UIColor(red: 15/255, green: 15/255, blue: 15/255, alpha: 1.0), backgroundColor: .clear, radius: 0, imageColor: .clear, borderWidth: 0, borderColor: UIColor.clear.cgColor)
    
    let btn3 = Button(image: UIImage(), text: "3", btnTitleColor: UIColor(red: 15/255, green: 15/255, blue: 15/255, alpha: 1.0), backgroundColor: .clear, radius: 0, imageColor: .clear, borderWidth: 0, borderColor: UIColor.clear.cgColor)
    
    let btn4 = Button(image: UIImage(), text: "4", btnTitleColor: UIColor(red: 15/255, green: 15/255, blue: 15/255, alpha: 1.0), backgroundColor: .clear, radius: 0, imageColor: .clear, borderWidth: 0, borderColor: UIColor.clear.cgColor)
    
    let btn5 = Button(image: UIImage(), text: "5", btnTitleColor: UIColor(red: 15/255, green: 15/255, blue: 15/255, alpha: 1.0), backgroundColor: .clear, radius: 0, imageColor: .clear, borderWidth: 0, borderColor: UIColor.clear.cgColor)
    
    let btn6 = Button(image: UIImage(), text: "6", btnTitleColor: UIColor(red: 15/255, green: 15/255, blue: 15/255, alpha: 1.0), backgroundColor: .clear, radius: 0, imageColor: .clear, borderWidth: 0, borderColor: UIColor.clear.cgColor)
    
    let btn7 = Button(image: UIImage(), text: "7", btnTitleColor: UIColor(red: 15/255, green: 15/255, blue: 15/255, alpha: 1.0), backgroundColor: .clear, radius: 0, imageColor: .clear, borderWidth: 0, borderColor: UIColor.clear.cgColor)
    
    let btn8 = Button(image: UIImage(), text: "8", btnTitleColor: UIColor(red: 15/255, green: 15/255, blue: 15/255, alpha: 1.0), backgroundColor: .clear, radius: 0, imageColor: .clear, borderWidth: 0, borderColor: UIColor.clear.cgColor)
    
    let btn9 = Button(image: UIImage(), text: "9", btnTitleColor: UIColor(red: 15/255, green: 15/255, blue: 15/255, alpha: 1.0), backgroundColor: .clear, radius: 0, imageColor: .clear, borderWidth: 0, borderColor: UIColor.clear.cgColor)
    
    let btn0 = Button(image: UIImage(), text: "0", btnTitleColor: UIColor(red: 15/255, green: 15/255, blue: 15/255, alpha: 1.0), backgroundColor: .clear, radius: 0, imageColor: .clear, borderWidth: 0, borderColor: UIColor.clear.cgColor)
    
    let btnStar = Button(image: UIImage(), text: "*", btnTitleColor: UIColor(red: 15/255, green: 15/255, blue: 15/255, alpha: 1.0), backgroundColor: .clear, radius: 0, imageColor: .clear, borderWidth: 0, borderColor: UIColor.clear.cgColor)
    
    let btnHash = Button(image: UIImage(), text: "#", btnTitleColor: UIColor(red: 15/255, green: 15/255, blue: 15/255, alpha: 1.0), backgroundColor: .clear, radius: 0, imageColor: .clear, borderWidth: 0, borderColor: UIColor.clear.cgColor)
    
    let btnCall = Button(image: UIImage(systemName: "phone.circle.fill"), text: "", btnTitleColor: .clear, backgroundColor: .clear, radius: 0, imageColor: .green, borderWidth: 0, borderColor: UIColor.clear.cgColor)
}
