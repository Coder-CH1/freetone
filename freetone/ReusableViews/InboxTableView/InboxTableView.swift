//
//  InboxTableView.swift
//  freetone
//
//  Created by Mac on 23/11/2024.
//

import UIKit

//MARK: - Reusable object -
class InboxTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - Object initialization -
    private var data: [String] = []
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
        self.separatorStyle = .singleLine
        self.separatorColor = .lightGray
        self.showsVerticalScrollIndicator = false
        self.translatesAutoresizingMaskIntoConstraints = false
        self.register(InboxTableViewCell.self, forCellReuseIdentifier: "InboxTableViewCell")
    }
    
    // MARK: - UITableViewDataSource -
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InboxTableViewCell", for: indexPath) as! InboxTableViewCell
        cell.backgroundColor = UIColor(red: 15/255, green: 15/255, blue: 15/255, alpha: 1.0)
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



