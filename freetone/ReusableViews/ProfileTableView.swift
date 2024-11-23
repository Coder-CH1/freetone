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
    private var items: [String] = ["Name", "My Account", "My Numbers", "Theme", "Notification", "Text", "Calls", "Voicemail Greeting"]
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
        self.backgroundColor = .lightGray
        self.register(ProfileTableViewCell.self, forCellReuseIdentifier: "ProfileTableViewCell")
    }
    
    // MARK: - UITableViewDataSource -
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
        let item = items[indexPath.row]
        cell.textLabel?.text = item
        return cell
    }
    
    // MARK: - DelegateFlowLayout -
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRowAt?(indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

