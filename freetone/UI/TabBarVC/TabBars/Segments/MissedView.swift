//
//  MissedView.swift
//  freetone
//
//  Created by Mac on 22/11/2024.
//

import UIKit

//MARK: - Setting the objects views and its properties
class MissedView: UIView {
    
    //MARK: - Objects -
    ////TABLEVIEW
    private let tableView = SegmentedTableView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubviewsAndLayout() 
    }
    
    // MARK: - Subviews and Layout -
    func setSubviewsAndLayout() {
        addSubview(tableView)
        tableView.backgroundColor = .purple
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }    
}
