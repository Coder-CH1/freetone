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
    var inboxDelegate: InboxTableViewDelegate?
    var data: [Message] = []
    
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
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InboxTableViewCell", for: indexPath) as! InboxTableViewCell
        let message = data[indexPath.row]
        cell.backgroundColor = UIColor(red: 15/255, green: 15/255, blue: 15/255, alpha: 1.0)
        cell.textLabel?.tintColor = .gray
        cell.configure(with: message)
        return cell
    }
    
    // MARK: - DelegateFlowLayout -
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMessage = data[indexPath.row]
        inboxDelegate?.didSelectMessage(selectedMessage)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let messageToDelete = data[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            Task {
                await DatabaseManager.shared.deleteDocument(message: messageToDelete)
                    self.data.remove(at: indexPath.row)
                    DispatchQueue.main.async {
                        tableView.deleteRows(at: [indexPath], with: .automatic)
                    }
                    completion(true)
            }
        }
        deleteAction.backgroundColor = .red
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeActions
    }
    
}
