//
//  TabBarViewController.swift
//  freetone
//
//  Created by Mac on 21/11/2024.
//

import UIKit

// MARK: -
class TabBarViewController: UITabBarController, UITabBarControllerDelegate  {
    // MARK: - Wrap ViewControllers in Navigation Controllers -
    let storeVC = UINavigationController(rootViewController: StoreViewController())
    let callsVC = UINavigationController(rootViewController: CallsViewController())
    let inboxVC = UINavigationController(rootViewController: InboxViewController())
    let numbersVC = UINavigationController(rootViewController: NumbersViewController())
    let profileVC = UINavigationController(rootViewController: ProfileViewController())
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        delegate = self
        setupViewControllers()
        selectedIndex = 1
    }
    
    func setupViewControllers() {
        // MARK: - Set titles for tab bar items -
        storeVC.tabBarItem.title = "Store"
        callsVC.tabBarItem.title = "Calls"
        inboxVC.tabBarItem.title = "Inbox"
        numbersVC.tabBarItem.title = "Numbers"
        profileVC.tabBarItem.title = "Profile"
        
        // MARK: - Set images for tab bar items -
        let tabBarImages = [
            UIImage(systemName: "bag.fill"),
            UIImage(systemName: "teletype"),
            UIImage(systemName: "bubble.middle.bottom"),
            UIImage(systemName: "number"),
            UIImage(systemName: "person.circle.fill")
        ]
        
        // MARK: - Assign ViewControllers and tab bar items -
        let viewControllers = [storeVC, callsVC, inboxVC, numbersVC, profileVC]
        for (index, viewController) in viewControllers.enumerated() {
            viewController.tabBarItem.image = tabBarImages[index]
        }
        
        // MARK: - Set ViewControllers for the tab bar controller -
        setViewControllers(viewControllers, animated: true)
        
        // MARK: - Customize tab bar appearance -
        self.tabBar.tintColor = .lightGray
        self.tabBar.barTintColor = UIColor(red: 0/255, green: 255/255, blue: 230/255, alpha: 1.0)
        self.tabBar.barTintColor = .gray
        UITabBar.appearance().backgroundColor = UIColor.gray
        
        // MARK: - Add a straight line at the top of the tab bar -
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: tabBar.frame.width, height: 0.5)
        topBorder.backgroundColor = UIColor.gray.cgColor
        tabBar.layer.addSublayer(topBorder)
    }
}
