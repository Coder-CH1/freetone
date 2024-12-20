//
//  InboxViewController.swift
//  freetone
//
//  Created by Mac on 21/11/2024.
//

import UIKit
import ContactsUI

//MARK: - UI -
class InboxViewController: BaseViewController {
    
    ////TABLEVIEW
    var menuTableView: UITableView!
    var isMenuViewVisible = false
    let menuView = UIView()
    let customView = UIView()
    private let tableView = InboxTableView(frame: .zero)
    
    ////BUTTON
    let plusButton = Button(image: UIImage(systemName: "plus"), text: "", btnTitleColor: .lightGray, backgroundColor: .systemPink, radius: 25, imageColor: .white, borderWidth: 0, borderColor: UIColor.clear.cgColor)
    
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
        
        let contactBtn = UIButton(type: .system)
        contactBtn.setImage(UIImage(systemName: "circle.hexagongrid.fill"), for: .normal)
        contactBtn.addTarget(self, action: #selector(btn2tapped), for: .touchUpInside)
        
        let infoBtn = UIButton(type: .system)
        infoBtn.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        
        //MARK: - Create stackview for the three buttons items at the right side -
        let stack = UIStackView(arrangedSubviews: [searchBtn, contactBtn, infoBtn])
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
            stack.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: -10),
        ])
        infoBtn.addTarget(self, action: #selector(toggleMenuView), for: .touchUpInside)
        setupMenuView()
        setSubviewsAndLayout()
        contactBtn.addTarget(self, action: #selector(btn2tapped), for: .touchUpInside)
    }
    
    // MARK: - Subviews and Layout -
    func setSubviewsAndLayout() {
        view.addSubview(tableView)
        view.addSubview(plusButton)
        buttonWidthConstraint = plusButton.widthAnchor.constraint(equalToConstant: 50)
        buttonHeightConstraint = plusButton.heightAnchor.constraint(equalToConstant: 50)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            plusButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            plusButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            buttonWidthConstraint!,
            buttonHeightConstraint!,
        ])
        callGetContacts()
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
    }
    
    //MARK: -
    @objc func btntapped() {
        
    }
    
    //MARK: - Method for navigating, customizes navigation bar of the DialViewcontroller -
    @objc func btn2tapped() {
            navigateToDialVC()
    }
    
    //MARK: -
    @objc func plusButtonTapped() {
        let vc = NewConversationViewController()
        navigationItem.backButtonTitle = ""
        vc.navigationItem.title = "New Conversation"
        navigationController?.pushViewController(vc, animated: false)
    }
    
    //MARK: - Setup menu view -
    func setupMenuView() {
        menuView.backgroundColor = .white
        menuView.layer.shadowOpacity = 0.3
        menuView.layer.shadowOffset = CGSize(width: 3, height: 3)
        menuView.translatesAutoresizingMaskIntoConstraints = false
        
        customView.addSubview(menuView)
        
        menuTableView = UITableView()
        menuTableView.translatesAutoresizingMaskIntoConstraints = false
        menuTableView.register(MenuTableViewCell.self, forCellReuseIdentifier: "MenuTableViewCell")
        menuTableView.dataSource = self
        menuTableView.delegate = self
        
        menuView.addSubview(menuTableView)
        
        NSLayoutConstraint.activate([
            menuView.topAnchor.constraint(equalTo: customView.topAnchor, constant: 50),
            menuView.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -10),
            menuView.widthAnchor.constraint(equalToConstant: 200),
            menuView.heightAnchor.constraint(equalToConstant: 120),
            
            menuTableView.topAnchor.constraint(equalTo: menuView.topAnchor),
            menuTableView.leadingAnchor.constraint(equalTo: menuView.leadingAnchor),
            menuTableView.trailingAnchor.constraint(equalTo: menuView.trailingAnchor),
            menuTableView.bottomAnchor.constraint(equalTo: menuView.bottomAnchor),
        ])
        menuView.transform = CGAffineTransform(translationX: 250, y: 0)
    }
    
    //MARK: - Show menu -
    @objc func toggleMenuView() {
        isMenuViewVisible = !isMenuViewVisible
        UIView.animate(withDuration: 0.3) {
            if self.isMenuViewVisible {
                self.menuView.transform = CGAffineTransform(translationX: 30, y: -20)
            } else {
                self.menuView.transform = CGAffineTransform(translationX: 250, y: 0)
            }
        }
    }
    
    //MARK: - Using the method for fetching array of CNContact objects -
    func callGetContacts() {
        let contacts = ContactManager.shared.getContactFromCNContact()
        for contact in contacts {
            print(contact.middleName)
            print(contact.familyName)
            print(contact.givenName)
        }
    }
}

//MARK: - Extension for Tableview protocols -
extension InboxViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        if indexPath.row == 0 {
            cell.textLabel?.text = "Contacts"
        } else {
            cell.textLabel?.text = "Refresh"
        }
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == menuView.subviews.first as? UITableView {
            if indexPath.row == 0 {
                print("0 index tapped")
                let contactPicker = CNContactPickerViewController()
                contactPicker.delegate = self
                present(contactPicker, animated: false)
            } else if indexPath.row == 1 {
                print("Refresh")
            }
        }
    }
}

//MARK: - Extension for contact picker protocols -
extension InboxViewController: CNContactPickerDelegate {
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        print("")
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        print("")
    }
}
