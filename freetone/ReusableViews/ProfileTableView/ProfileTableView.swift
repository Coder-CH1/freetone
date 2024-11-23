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
    
    init(frame: CGRect){
        super.init(frame: frame, style: .plain)
        customizeTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Customizing -
    func customizeTableView() {
        self.delegate = self
        self.dataSource = self
        self.showsVerticalScrollIndicator = false
        self.translatesAutoresizingMaskIntoConstraints = false
        self.register(ProfileTableViewCell.self, forCellReuseIdentifier: "ProfileTableViewCell")
        
        self.sectionHeaderTopPadding = 0
    }
    
    // MARK: - UITableViewDataSource -
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        } else if section == 1{
            return items1.count
        } else {
            return items2.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
        if indexPath.section == 0 {
            cell.textLabel?.text = ""
        } else if indexPath.section == 1 {
            cell.textLabel?.text = items1[indexPath.row]
        } else {
            cell.textLabel?.text = items2[indexPath.row]
        }
        return cell
    }
    
    // MARK: - DelegateFlowLayout -
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRowAt?(indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        if section == 0 {
            headerView.backgroundColor = .purple
            let img = UIImageView(image: UIImage(systemName: "person.circle"))
            img.translatesAutoresizingMaskIntoConstraints = false
            
            let label = UILabel()
            label.text = "user"
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
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
            headerView.backgroundColor = .black
            let label = UILabel()
            label.text = "Account"
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            label.translatesAutoresizingMaskIntoConstraints = false
            headerView.addSubview(label)
            
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 14),
                label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
                label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -14)
            ])
        } else {
            headerView.backgroundColor = .brown
            let label = UILabel()
            label.text = "Settings"
            label.textColor = .white
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 80
        } else if section == 1 {
            return 50
        } else {
            return 50
        }
    }
}

