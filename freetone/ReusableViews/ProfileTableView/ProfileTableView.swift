//
//  TableView.swift
//  freetone
//
//  Created by Mac on 23/11/2024.
//

//
//  ReusableCollectionVC.swift
//  Astrotalk
//
//  Created by Mac on 19/04/2024.
//

import UIKit

//MARK: - Reusable object -
class ProfileTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - Object initialization -
    private var items1: [String] = ["My Account", "My Numbers"]
    private var items2: [String] = ["Theme", "Notification", "Text", "Calls", "Voicemail Greeting"]
    var didSelectRowAt: ((IndexPath) -> Void)?
    
    ////BUTTON
    let logoutButton = Button(image: UIImage(), text: "Log Out", btnTitleColor: .white, backgroundColor: .black, radius: 8, imageColor: .clear, borderWidth: 0, borderColor: UIColor.clear.cgColor)
    
    //MARK: - Lifecycle -
    init(frame: CGRect){
        super.init(frame: frame, style: .plain)
        customizeTableView()
        logoutButton.addTarget(self, action: #selector(logoutUser), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Customizing -
    func customizeTableView() {
        self.delegate = self
        self.dataSource = self
        self.separatorStyle = .singleLine
        self.separatorColor = .lightGray
        self.showsVerticalScrollIndicator = false
        self.translatesAutoresizingMaskIntoConstraints = false
        self.register(ProfileTableViewCell.self, forCellReuseIdentifier: "ProfileTableViewCell")
        
        self.sectionHeaderTopPadding = 0
    }
    
    // MARK: - UITableViewDataSource -
    ////NUMBER OF ITEMS IN EACH SECTION
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        } else if section == 1{
            return items1.count
        } else {
            return items2.count
        }
    }
    
    ////SECTIONS IN THE TABLEVIEW
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    ////ACCESSING AND MANIPULATING THE ITEMS IN THE ROW
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
        if indexPath.section == 0 {
            cell.textLabel?.text = ""
            cell.backgroundColor = UIColor(red: 15/255, green: 15/255, blue: 15/255, alpha: 1.0)
        } else if indexPath.section == 1 {
            cell.textLabel?.text = items1[indexPath.row]
            cell.textLabel?.textColor = .white
            cell.backgroundColor = UIColor(red: 15/255, green: 15/255, blue: 15/255, alpha: 1.0)
        } else {
            cell.textLabel?.text = items2[indexPath.row]
            cell.textLabel?.textColor = .white
            cell.backgroundColor = UIColor(red: 15/255, green: 15/255, blue: 15/255, alpha: 1.0)
        }
        return cell
    }
    
    // MARK: - UITableViewDelegate -
    ////NAVIGATING FROM THE ROWS TO OTHER SCREENS
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRowAt?(indexPath)
    }
    
    ////HEIGHT FOR THE ROW
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    ////OBJECTS IN EACH SECTION HEADER
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        if section == 0 {
            headerView.backgroundColor = UIColor(red: 15/255, green: 15/255, blue: 15/255, alpha: 1.0)
            let img = UIImageView(image: UIImage(systemName: "person.circle"))
            img.translatesAutoresizingMaskIntoConstraints = false
            
            if let profileImageUrl = AuthManager.shared.currentUser?.profileImageUrl, let url = URL(string: profileImageUrl) {
                img.load(url: url)
            } else {
                img.image = UIImage(systemName: "person.circle")
            }
                
            let label = UILabel()
            label.text = AuthManager.shared.email
            label.textColor = UIColor(red: 0/255, green: 255/255, blue: 230/255, alpha: 1.0)
            label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            label.translatesAutoresizingMaskIntoConstraints = false
            
            headerView.addSubview(img)
            headerView.addSubview(label)
            
            NSLayoutConstraint.activate([
                img.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 14),
                img.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
                img.heightAnchor.constraint(equalToConstant: 60),
                img.widthAnchor.constraint(equalToConstant: 60),
            
                label.leadingAnchor.constraint(equalTo: img.trailingAnchor, constant: 10),
                label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            ])
        } else if section == 1 {
            headerView.backgroundColor = UIColor(red: 15/255, green: 15/255, blue: 15/255, alpha: 1.0)
            let label = UILabel()
            label.text = "Account"
            label.textColor = UIColor(red: 0/255, green: 255/255, blue: 230/255, alpha: 1.0)
            label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            label.translatesAutoresizingMaskIntoConstraints = false
            headerView.addSubview(label)
            
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 14),
                label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
                label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -14)
            ])
        } else {
            headerView.backgroundColor = UIColor(red: 15/255, green: 15/255, blue: 15/255, alpha: 1.0)
            let label = UILabel()
            label.text = "Settings"
            label.textColor = UIColor(red: 0/255, green: 255/255, blue: 230/255, alpha: 1.0)
            label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            label.translatesAutoresizingMaskIntoConstraints = false
            headerView.addSubview(label)
            
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 14),
                label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
                label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -14)
            ])
        }
        return headerView
    }
    
    ////HEIGHT FOT THE HEADER SECTION
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 80
        } else if section == 1 {
            return 50
        } else {
            return 50
        }
    }
    
    ////OBJECT IN THE FOOTER SECTION AND ITS CONSTRAINT
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 2 {
            let footerView = UIView()
            footerView.backgroundColor = UIColor(red: 15/255, green: 15/255, blue: 15/255, alpha: 1.0)
            
            footerView.addSubview(logoutButton)
            
            NSLayoutConstraint.activate([
                logoutButton.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 30),
                logoutButton.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 50),
                logoutButton.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -50),
                logoutButton.heightAnchor.constraint(equalToConstant: 50),
            ])
            return footerView
        }
        return nil
    }
    
    ////HEIGHT FOR THE FOOTER SECTION
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 2 {
            return 100
        }
        return 0.01
    }
    
    @objc func logoutUser() {
        Task {
            await AuthManager.shared.logout()
        }
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
