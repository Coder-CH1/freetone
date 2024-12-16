//
//  NumbersViewController.swift
//  freetone
//
//  Created by Mac on 21/11/2024.
//

import UIKit
//MARK: - UI -
class NumbersViewController: UIViewController {
    
    //MARK: - Objects -
    ////LABEL
    let titleLabel = Label(label: "My numbers", textColor: .white, font: UIFont.systemFont(ofSize: 16, weight: .bold))
    
    //MARK: - Create a custom view for the navigation bar -
    fileprivate lazy var customView: UIView = {
        let customView = UIView()
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.backgroundColor = .darkGray
        navigationItem.titleView = customView
        return customView
    }()
    
    ////
    let phoneButton = Button(image: UIImage(systemName: "plus"), text: "", btnTitleColor: .lightGray, backgroundColor: .systemPink, radius: 25, imageColor: .white, borderWidth: 0, borderColor: UIColor.clear.cgColor)
    
    var buttonExpanded = false
    
    var buttonWidthConstraint: NSLayoutConstraint?
    var buttonHeightConstraint: NSLayoutConstraint?
    
    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    //MARK: - Setting up navigation items -
    private func setupNavigationBar() {
        if let navigationBar = navigationController?.navigationBar {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .darkGray
            appearance
                .titleTextAttributes = [.foregroundColor: UIColor.white]
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
        }
        setSubviewsAndLayout()
    }
    
    // MARK: - Subviews and Layout -
    func setSubviewsAndLayout() {
        view.addSubview(customView)
        view.addSubview(phoneButton)
        customView.addSubview(titleLabel)
        buttonWidthConstraint = phoneButton.widthAnchor.constraint(equalToConstant: 50)
        buttonHeightConstraint = phoneButton.heightAnchor.constraint(equalToConstant: 50)
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: view.topAnchor),
            //customView.heightAnchor.constraint(equalToConstant: 250),
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customView.widthAnchor.constraint(equalToConstant: view.bounds.width),
            
            titleLabel.topAnchor.constraint(equalTo: customView.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 20),
            
            phoneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            phoneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            buttonWidthConstraint!,
            buttonHeightConstraint!,
        ])
    }
    
    //MARK: - Life Cycle -
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        expandButton()
    }
    
    // MARK: - Method to expand the button -
    func expandButton() {
        UIView.animate(withDuration: 1.2) {
            ////MODIFY THE BUTTON SIZE AND CORNER RADIUS
            self.phoneButton.layer.cornerRadius = 25
            self.buttonWidthConstraint?.constant = 250
            self.buttonHeightConstraint?.constant = 50
            
            ////UPDATE TITLE BUTTON AND IMAGE
            self.phoneButton.setTitleColor(.white, for: .normal)
            self.phoneButton.setImage(UIImage(systemName: "plus"), for: .normal)
            self.phoneButton.setTitle("  Get a first phone number", for: .normal)
            
            self.view.layoutIfNeeded()
        }
    }
}
