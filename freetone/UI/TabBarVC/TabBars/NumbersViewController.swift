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
        customView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: view.topAnchor),
            customView.heightAnchor.constraint(equalToConstant: 210),
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            
            titleLabel.topAnchor.constraint(equalTo: customView.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 20),
        ])
    }
}
