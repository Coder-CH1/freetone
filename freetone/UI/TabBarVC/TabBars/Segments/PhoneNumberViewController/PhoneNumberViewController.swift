//
//  PhoneNumberViewController.swift
//  freetone
//
//  Created by Mac on 24/11/2024.
//

import UIKit
//MARK: - UI -
class PhoneNumberViewController: UIViewController {
    //MARK: - Objects -
    
    let phonePadView = PhoneNumberPadView()

    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setSubviewsAndLayout()
    }
    
    // MARK: - Subviews and Layout -
    func setSubviewsAndLayout() {
        view.addSubview(phonePadView)        
        NSLayoutConstraint.activate([
            phonePadView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            phonePadView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            phonePadView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            phonePadView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        phonePadView.translatesAutoresizingMaskIntoConstraints = false
    }
}
