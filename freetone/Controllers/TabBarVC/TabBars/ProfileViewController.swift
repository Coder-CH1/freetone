//
//  ProfileViewController.swift
//  freetone
//
//  Created by Mac on 21/11/2024.
//

import UIKit

class ProfileViewController: UIViewController, ProfileTableViewDelegate {
    //MARK: - Objects -
    ////LABEL
    let titleLabel = Label(label: "Account & Settings", textColor: .white, font: UIFont.systemFont(ofSize: 16, weight: .bold))
    
    //MARK: - Create a custom view for the navigation bar -
    ////VIEW
    fileprivate lazy var customView: UIView = {
        let customView = UIView()
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.backgroundColor = .darkGray
        navigationItem.titleView = customView
        return customView
    }()
    
    //// CUSTOMTABLEVIEW
    private let tableView = ProfileTableView(frame: .zero)
    
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
        tableView.profileTableViewDelegate = self
        view.addSubview(customView)
        view.addSubview(tableView)
        customView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: view.topAnchor),
            customView.heightAnchor.constraint(equalToConstant: 210),
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            
            titleLabel.topAnchor.constraint(equalTo: customView.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 20),
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func didLogout() {
        let vc = SignInViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
}
