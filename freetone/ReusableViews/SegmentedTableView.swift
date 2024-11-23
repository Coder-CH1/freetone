//
//  SegmentedTableView.swift
//  freetone
//
//  Created by Mac on 23/11/2024.
//

import UIKit

//MARK: - Reusable object -
class SegmentedTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    
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
        self.showsVerticalScrollIndicator = false
        self.translatesAutoresizingMaskIntoConstraints = false
        //self.backgroundColor = .lightGray
        self.register(SegmentedTableViewCell.self, forCellReuseIdentifier: "SegmentedTableViewCell")
    }
    
    // MARK: - UITableViewDataSource -
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SegmentedTableViewCell", for: indexPath) as! SegmentedTableViewCell
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


