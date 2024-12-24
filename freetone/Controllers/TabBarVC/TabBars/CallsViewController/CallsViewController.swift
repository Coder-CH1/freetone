//
//  CallsViewController.swift
//  freetone
//
//  Created by Mac on 21/11/2024.
//

import UIKit
import ContactsUI

//MARK: - UI -
class CallsViewController: BaseViewController {
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
    
    ////SEGMENTED CONTROL
    public lazy var segmentedControl: UISegmentedControl = {
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
        customView.addSubview(segmentedControl)
        customView.addSubview(label)
        let subviews = [customView, allView, missedView, voicemailView, dialButton]
        for subview in subviews {
            view.addSubview(subview)
        }
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: view.topAnchor),
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            label.topAnchor.constraint(equalTo: customView.topAnchor, constant: -20),
            label.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 20),
            
            segmentedControl.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            segmentedControl.leadingAnchor.constraint(equalTo: customView.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: customView.trailingAnchor),
            segmentedControl.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: -5),
            segmentedControl.heightAnchor.constraint(equalToConstant: 30),
            segmentedControl.widthAnchor.constraint(equalToConstant: view.frame.width),
            
            allView.topAnchor.constraint(equalTo: customView.topAnchor, constant: 5),
            allView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            allView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            allView.heightAnchor.constraint(equalToConstant: view.frame.height),
            
            missedView.topAnchor.constraint(equalTo: customView.topAnchor, constant: 5),
            missedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            missedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            missedView.heightAnchor.constraint(equalToConstant: view.frame.height),
            
            voicemailView.topAnchor.constraint(equalTo: customView.topAnchor, constant: 5),
            voicemailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            voicemailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            voicemailView.heightAnchor.constraint(equalToConstant: view.frame.height),
            
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
        dialButton.addTarget(self, action: #selector(dialButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - Method for navigating, customizes navigation bar of the DialViewcontroller -
    @objc func dialButtonTapped() {
        navigateToDialVC()
    }
    
    //MARK: - Method that opens the contact picker viewcontroller -
    @objc override func contactButtonTapped() {
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
        if let phoneNumber = contact.phoneNumbers.first?.value.stringValue {
            let dialVC = DialerViewController()
            dialVC.selectedPhoneNumber = phoneNumber
            navigationController?.pushViewController(dialVC, animated: false)
        }
        print("")
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        print("")
    }
}
