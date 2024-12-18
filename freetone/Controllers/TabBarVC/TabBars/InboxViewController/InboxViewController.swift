//
//  InboxViewController.swift
//  freetone
//
//  Created by Mac on 21/11/2024.
//

import UIKit
//MARK: - UI -
class InboxViewController: UIViewController {
    
    ////TABLEVIEW
    let menuView = UIView()
    let customView = UIView()
    private let tableView = InboxTableView(frame: .zero)
    
    ////BUTTON
    let phoneButton = Button(image: UIImage(systemName: "plus"), text: "", btnTitleColor: .lightGray, backgroundColor: .systemPink, radius: 25, imageColor: .white, borderWidth: 0, borderColor: UIColor.clear.cgColor)
    
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
        
        //MARK: - Create a custom view for the navigation bar -
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.backgroundColor = .darkGray
        view.addSubview(customView)
        
        //MARK: - Add the customview to the navigation bar -
        navigationItem.titleView = customView
        
        //MARK: - Set up the label on the left -
        let label = UILabel()
        label.text = "Inbox"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        customView.addSubview(label)
        
        //MARK: - Create three buttons (UIBarButtonItems) -
        let searchBtn = UIButton(type: .system)
        searchBtn.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchBtn.addTarget(self, action: #selector(btntapped), for: .touchUpInside)
        
        let callBtn = UIButton(type: .system)
        callBtn.setImage(UIImage(systemName: "circle.hexagongrid.fill"), for: .normal)
        callBtn.addTarget(self, action: #selector(btn2tapped), for: .touchUpInside)
        
        let infoBtn = UIButton(type: .system)
        infoBtn.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        infoBtn.addTarget(self, action: #selector(btn3tapped), for: .touchUpInside)
        
        //MARK: - Create stackview for the three buttons items at the right side -
        let stack = UIStackView(arrangedSubviews: [searchBtn, callBtn, infoBtn])
        stack.axis = .horizontal
        stack.spacing = 30
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        customView.addSubview(stack)
        
        //MARK: - Customize the navigationbar -
        navigationController?.navigationBar.tintColor = .white
        
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            label.topAnchor.constraint(equalTo: customView.topAnchor, constant: 5),
            label.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 20),
            
            stack.topAnchor.constraint(equalTo: customView.topAnchor, constant: 5),
            stack.leadingAnchor.constraint(equalTo: label.safeAreaLayoutGuide.trailingAnchor, constant: 130),
            stack.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -20),
        ])
        infoBtn.addTarget(self, action: #selector(showMenuTapped), for: .touchUpInside)
        setupMenuView()
        setSubviewsAndLayout()
    }
    
    // MARK: - Subviews and Layout -
    func setSubviewsAndLayout() {
        view.addSubview(tableView)
        view.addSubview(phoneButton)
        buttonWidthConstraint = phoneButton.widthAnchor.constraint(equalToConstant: 50)
        buttonHeightConstraint = phoneButton.heightAnchor.constraint(equalToConstant: 50)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            phoneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            phoneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            buttonWidthConstraint!,
            buttonHeightConstraint!,
        ])
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
    
    func setupMenuView() {
        menuView.backgroundColor = .white
        menuView.layer.shadowOpacity = 0.3
        menuView.layer.shadowOffset = CGSize(width: -3, height: 3)
        menuView.translatesAutoresizingMaskIntoConstraints = false
        
        customView.addSubview(menuView)
        
        let menuTableView = UITableView()
        menuTableView.translatesAutoresizingMaskIntoConstraints = false
        menuTableView.register(MenuTableViewCell.self, forCellReuseIdentifier: "MenuTableViewCell")
        menuTableView.dataSource = self
        menuTableView.delegate = self
        
        menuView.addSubview(menuTableView)
        
        NSLayoutConstraint.activate([
            menuView.topAnchor.constraint(equalTo: customView.topAnchor, constant: -300),
            menuView.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: 200),
            menuView.widthAnchor.constraint(equalToConstant: 200),
            menuView.heightAnchor.constraint(equalToConstant: 200),
            
            menuTableView.topAnchor.constraint(equalTo: menuView.topAnchor),
            menuTableView.leadingAnchor.constraint(equalTo: menuView.leadingAnchor),
            menuTableView.trailingAnchor.constraint(equalTo: menuView.trailingAnchor),
            menuTableView.bottomAnchor.constraint(equalTo: menuView.bottomAnchor),
        ])
    }
    @objc func showMenuTapped() {
        UIView.animate(withDuration: 0.3) {
            self.menuView.transform = CGAffineTransform(translationX: -180, y: 200)
        }
    }
    
    func hideMenu() {
        UIView.animate(withDuration: 0.3) {
            self.menuView.transform = .identity
        }
    }
}

extension InboxViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        cell.textLabel?.text = "Options \(indexPath.row) + 1"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        hideMenu()
    }
}