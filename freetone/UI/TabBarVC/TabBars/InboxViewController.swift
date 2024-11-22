//
//  InboxViewController.swift
//  freetone
//
//  Created by Mac on 21/11/2024.
//

import UIKit

class InboxViewController: UIViewController {
    
    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    //MARK: - Setting up navigation items -
    private func setupNavigationBar() {
        let label = UILabel()
        label.text = "Inbox"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
        let leftBarButton = UIBarButtonItem(customView: label)
        navigationItem.leftBarButtonItem = leftBarButton
        
        let searchBtn = UIButton(type: .system)
        searchBtn.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchBtn.addTarget(self, action: #selector(btntapped), for: .touchUpInside)
        
        let callBtn = UIButton(type: .system)
        callBtn.setImage(UIImage(systemName: "circle.hexagongrid.fill"), for: .normal)
        callBtn.addTarget(self, action: #selector(btn2tapped), for: .touchUpInside)
        
        let infoBtn = UIButton(type: .system)
        infoBtn.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        infoBtn.addTarget(self, action: #selector(btn3tapped), for: .touchUpInside)
        
        let stack = UIStackView(arrangedSubviews: [searchBtn, callBtn, infoBtn])
        stack.axis = .horizontal
        stack.spacing = 0
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        let rightBarButton = UIBarButtonItem(customView: stack)
        navigationItem.rightBarButtonItem = rightBarButton
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.backgroundColor = .darkGray
        
        NSLayoutConstraint.activate([
            stack.heightAnchor.constraint(equalToConstant: 150),
            stack.widthAnchor.constraint(equalToConstant: 240),
        ])
        
        navigationController?.navigationBar.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    //MARK: -
    @objc func btntapped() {
        
    }
    
    //MARK: -
    @objc func btn2tapped() {
        
    }
    
    //MARK: -
    @objc func btn3tapped() {
        
    }
    
}
