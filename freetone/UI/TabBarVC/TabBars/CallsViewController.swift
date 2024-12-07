//
//  CallsViewController.swift
//  freetone
//
//  Created by Mac on 21/11/2024.
//

import UIKit
//MARK: - UI -
class CallsViewController: UIViewController {
    //MARK: - Objects -
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
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
    
    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
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
        customView.addSubview(label)
        customView.addSubview(segmentedControl)
        let subviews = [customView, allView, missedView, voicemailView]
        for subview in subviews {
            view.addSubview(subview)
        }
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: view.topAnchor),
            customView.heightAnchor.constraint(equalToConstant: 210),
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            
            label.topAnchor.constraint(equalTo: customView.topAnchor, constant: -20),
            label.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 20),
            
            segmentedControl.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 15),
            segmentedControl.leadingAnchor.constraint(equalTo: customView.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: customView.trailingAnchor),
            segmentedControl.heightAnchor.constraint(equalToConstant: 30),
            
            allView.topAnchor.constraint(equalTo: customView.bottomAnchor, constant: 15),
            allView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            allView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            allView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            allView.heightAnchor.constraint(equalToConstant: view.bounds.height),
            
            missedView.topAnchor.constraint(equalTo: customView.bottomAnchor, constant: 15),
            missedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            missedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            missedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            missedView.heightAnchor.constraint(equalToConstant: view.bounds.height),
            
            voicemailView.topAnchor.constraint(equalTo: customView.bottomAnchor, constant: 15),
            voicemailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            voicemailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            voicemailView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            voicemailView.heightAnchor.constraint(equalToConstant: view.bounds.height)
        ])
        missedView.isHidden =  true
        voicemailView.isHidden = true
        
        allView.translatesAutoresizingMaskIntoConstraints = false
        missedView.translatesAutoresizingMaskIntoConstraints = false
        voicemailView.translatesAutoresizingMaskIntoConstraints = false
        
        setupSegmentedControlIndicator()
        setupSegmentsTappedAction()
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
        segmentedControlIndicatorView.frame = CGRect(x: -20, y: 42, width: segmentedWidth * 1.68, height: 2)
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
