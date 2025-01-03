//
//  AllView.swift
//  freetone
//
//  Created by Mac on 22/11/2024.
//

import UIKit

//MARK: - Setting the objects views and its properties
class AllView: UIView {
    
    //MARK: - Objects -
    ////TABLEVIEW
    private let tableView = SegmentedTableView(frame: .zero)
    var calls: [Call] = []
    
    ////BUTTON
    let phoneButton = Button(image: UIImage(systemName: "circle.hexagongrid.fill"), text: "", btnTitleColor: .lightGray, backgroundColor: .systemPink, radius: 25, imageColor: .white, borderWidth: 0, borderColor: UIColor.clear.cgColor)
    
    var buttonWidthConstraint: NSLayoutConstraint?
    var buttonHeightConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        fetchCallsData()
        setSubviewsAndLayout()
    }
    
    // MARK: - Subviews and Layout -
    func setSubviewsAndLayout() {
        addSubview(tableView)
        addSubview(phoneButton)
        buttonWidthConstraint = phoneButton.widthAnchor.constraint(equalToConstant: 50)
        buttonHeightConstraint = phoneButton.heightAnchor.constraint(equalToConstant: 50)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            phoneButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            phoneButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            buttonWidthConstraint!,
            buttonHeightConstraint!,
        ])
        tableView.backgroundColor = .blue
        phoneButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    // MARK: -
    @objc func buttonTapped() {
        let vc = DialerViewController()
        vc.modalPresentationStyle = .fullScreen
    }
    
    // MARK: - Method to fetch the calls data to the ui -
    func fetchCallsData() {
        Task {
            if let fetchedCalls = await DatabaseManager.shared.fetchCalls() {
                self.calls = fetchedCalls
                print("fetched calls: \(fetchedCalls)")
                DispatchQueue.main.async {
                    self.tableView.calls = self.calls
                    self.tableView.reloadData()
                }
            } else {
                print("failed to fetch calls")
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
