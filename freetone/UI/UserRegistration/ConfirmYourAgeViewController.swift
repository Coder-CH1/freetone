//
//  ConfirmYourAgeViewController.swift
//  freetone
//
//  Created by Mac on 21/11/2024.
//

import UIKit
//MARK: - UI -
class ConfirmYourAgeViewController: UIViewController {
    
    //MARK: - Objects -
    ////UIImageView
    fileprivate lazy var appLogo: UIImageView = {
        let logo = UIImageView(image: UIImage(named: "logo"))
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.tintColor = UIColor(red: 0/255, green: 255/255, blue: 230/255, alpha: 1.0)
        logo.contentMode = .scaleAspectFit
        return logo
    }()
    
    ////LABEL
    fileprivate lazy var appLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "FreeTone"
        label.textColor = .white
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    ////STACKVIEW
    fileprivate lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [appLogo, appLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = -80
        stack.alignment = .center
        return stack
    }()
    
    ////LABEL
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Are you over the\n age of 13?"
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 22, weight: .black)
        return label
    }()
    
    ////LABEL
    fileprivate lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "You must be at least 13 years old\n to create a Freetone account"
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    let noButton = Button(image: UIImage(systemName: "minus.circle.fill"), text: "No", btnTitleColor: .lightGray, backgroundColor: .clear, radius: 5, imageColor: .red, borderWidth: 2, borderColor: UIColor.red.cgColor)
    
    let yesButton = Button(image: UIImage(systemName: "checkmark.square.fill"), text: "Yes", btnTitleColor: .lightGray, backgroundColor: .clear, radius: 5, imageColor: .green, borderWidth: 2, borderColor: UIColor.green.cgColor)
    
    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setSubviewsAndLayout()
    }
    
    // MARK: - Subviews and Layout -
    func setSubviewsAndLayout() {
        view.addSubview(stackView)
        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(noButton)
        view.addSubview(yesButton)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            appLogo.widthAnchor.constraint(equalToConstant: 80),
            appLogo.heightAnchor.constraint(equalToConstant: 50),
            
            titleLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 100),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            subTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            noButton.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 20),
            noButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            noButton.heightAnchor.constraint(equalToConstant: 65),
            noButton.widthAnchor.constraint(equalToConstant: 150),
            
            yesButton.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 20),
            yesButton.leadingAnchor.constraint(equalTo: noButton.trailingAnchor, constant: 60),
            
            yesButton.heightAnchor.constraint(equalToConstant: 65),
            yesButton.widthAnchor.constraint(equalToConstant: 150),
        ])
        noButton.addTarget(self, action: #selector(noButtonTapped), for: .touchUpInside)
        yesButton.addTarget(self, action: #selector(yesButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - The method that shows the error message -
    @objc func noButtonTapped() {
        subTitleLabel.textColor = .red
    }
    
    //MARK: - The method that navigates to the registration screen -
    @objc func yesButtonTapped() {
        subTitleLabel.textColor = .lightGray
        let vc = RegisterWithEmailViewController()
        self.navigationController?.pushViewController(vc, animated: false)
        let backButton = UIBarButtonItem(title: "     Register with email", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
        backButton.tintColor = .white
    }
}
