//
//  CallsViewController.swift
//  freetone
//
//  Created by Mac on 21/11/2024.
//

import UIKit
import ContactsUI
import Contacts
//MARK: - UI -
class CallsViewController: UIViewController {
    //MARK: - Objects -
    let contactStore = CNContactStore()
    let allView = AllView()
    let missedView = MissedView()
    let voicemailView = VoicemailView()
    let segmentedControlIndicatorView = UIView()
    
    //MARK: - Create a custom view for the navigation bar -
    fileprivate lazy var customView: UIView = {
        let customView = UIView()
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.backgroundColor = .darkGray
        navigationItem.titleView = customView
        return customView
    }()
    
    //MARK: - Set up the label on the left -
    fileprivate lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Calls"
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    ////STACKVIEW
    fileprivate lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [label, segmentedControl])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .center
        return stack
    }()
    
    ////SEGMENTED CONTROL
    fileprivate lazy var segmentedControl: UISegmentedControl = {
        let items = ["ALL", "MISSED", "VOICEMAIL"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor(red: 0/255, green: 255/255, blue: 230/255, alpha: 1.0), ], for: .selected)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.lightGray], for: .normal)
        segmentedControl.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        segmentedControl.setBackgroundImage(UIImage(), for: .selected, barMetrics: .default)
        segmentedControl.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        return segmentedControl
    }()
    
    let dialButton = Button(image: UIImage(systemName: "circle.hexagongrid.fill"), text: "", btnTitleColor: .clear, backgroundColor: .systemPink, radius: 25, imageColor: .white, borderWidth: 0, borderColor: UIColor.clear.cgColor)
    
    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        callGetContacts()
        setupNavigationBar()
    }
    
    //MARK: - Setting up navigation items -
    func setupNavigationBar() {
        if let navigationBar = navigationController?.navigationBar {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .darkGray
            appearance
                .titleTextAttributes = [.foregroundColor: UIColor.white]
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
        }
        setSubviewsAndLayout()
    }
    
    // MARK: - Subviews and Layout -
    func setSubviewsAndLayout() {
        customView.addSubview(stackView)
        let subviews = [customView, allView, missedView, voicemailView, dialButton]
        for subview in subviews {
            view.addSubview(subview)
        }
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: view.topAnchor),
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customView.heightAnchor.constraint(equalToConstant: 150),
            
            stackView.topAnchor.constraint(equalTo: customView.topAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: customView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: customView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: -10),
            
            allView.topAnchor.constraint(equalTo: customView.topAnchor, constant: 10),
            allView.leadingAnchor.constraint(equalTo: customView.leadingAnchor),
            allView.trailingAnchor.constraint(equalTo: customView.trailingAnchor),
            
            missedView.topAnchor.constraint(equalTo: customView.topAnchor, constant: 10),
            missedView.leadingAnchor.constraint(equalTo: customView.leadingAnchor),
            missedView.trailingAnchor.constraint(equalTo: customView.trailingAnchor),
            
            voicemailView.topAnchor.constraint(equalTo: customView.topAnchor, constant: 10),
            voicemailView.leadingAnchor.constraint(equalTo: customView.leadingAnchor),
            voicemailView.trailingAnchor.constraint(equalTo: customView.trailingAnchor),
            
            dialButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            dialButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dialButton.heightAnchor.constraint(equalToConstant: 50),
            dialButton.widthAnchor.constraint(equalToConstant: 50),
        ])
        missedView.isHidden =  true
        voicemailView.isHidden = true
        
        allView.translatesAutoresizingMaskIntoConstraints = false
        missedView.translatesAutoresizingMaskIntoConstraints = false
        voicemailView.translatesAutoresizingMaskIntoConstraints = false
        
        setupSegmentedControlIndicator()
        setupSegmentsTappedAction()
        
        dialButton.addTarget(self, action: #selector(dialbuttontapped), for: .touchUpInside)
    }
    
    //MARK: - Method for navigating, customizes navigation bar of the DialViewcontroller -
    @objc func dialbuttontapped() {
        let vc = DialerViewController()
        navigationController?.pushViewController(vc, animated: false)
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        backButton.setTitle("Dial a number", for: .normal)
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .black)
        
        backButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        backButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -25, bottom: 0, right: 0)
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        let backItem = UIBarButtonItem(customView: backButton)
        vc.navigationItem.leftBarButtonItem = backItem
        
        let contactButton = UIBarButtonItem(
            image: UIImage(systemName: "person.crop.square"),
            style: .plain,
            target: self,
            action: #selector(contactButtonTapped)
        )
        vc.navigationItem.rightBarButtonItem = contactButton
        navigationController?.navigationBar.tintColor = .white
    }
    
    //MARK: - Method for navigating to the present viewcontroller -
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Method that opens the contact picker viewcontroller -
    @objc func contactButtonTapped() {
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = self
        present(contactPicker, animated: true)
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
    
    //MARK: - The tap button event that selects either the login view/signup view -
    func setupSegmentsTappedAction() {
        let action = UIAction { [weak self] _ in
            self?.segmentedControlChanged(self!.segmentedControl)
        }
        segmentedControl.addAction(action, for: .valueChanged)
    }
    
    //MARK: - Setting the properties of the segmented control -
    func setupSegmentedControlIndicator() {
        segmentedControlIndicatorView.backgroundColor = UIColor(red: 0/255, green: 255/255, blue: 230/255, alpha: 1.0)
        let segmentedWidth = segmentedControl.frame.width/CGFloat(segmentedControl.numberOfSegments)
        segmentedControlIndicatorView.frame = CGRect(x: -15, y: 42, width: segmentedWidth * 1.70, height: 2)
        customView.addSubview(segmentedControlIndicatorView)
        
        NSLayoutConstraint.activate([
            segmentedControlIndicatorView.widthAnchor.constraint(equalTo: segmentedControl.widthAnchor, multiplier: 1.2 / CGFloat(segmentedControl.numberOfSegments))
        ])
    }
    
    //MARK: - The segmented control event functionality that selects either of the segments -
    func segmentedControlChanged(_ sender: UISegmentedControl) {
        allView.isHidden = sender.selectedSegmentIndex != 0
        missedView.isHidden = sender.selectedSegmentIndex != 1
        voicemailView.isHidden = sender.selectedSegmentIndex != 2
        
        let segmentedWidth = segmentedControl.frame.width/CGFloat(segmentedControl.numberOfSegments)
        let indicatorX = CGFloat(sender.selectedSegmentIndex) * segmentedWidth
        UIView.animate(withDuration: 0.2) {
            self.segmentedControlIndicatorView.frame.origin.x = indicatorX - 15
        }
    }
}

//MARK: - Extension for protocol delegates for opening the device contact -
extension CallsViewController: CNContactPickerDelegate {
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        print("")
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        print("")
    }
}
