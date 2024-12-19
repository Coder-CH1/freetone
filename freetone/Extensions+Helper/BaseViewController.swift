//
//  BaseViewController.swift
//  freetone
//
//  Created by Mac on 02/12/2024.
//

import UIKit

//MARK: - Parent class -
class BaseViewController: UIViewController {
    
    //MARK: - Method to show alert -
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
    
    //MARK: - Method to show alert -
    func showAlert(on viewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        viewController.present(alert, animated: true)
    }
    
    //MARK: - 
    func navigateToDialVC() {
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
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func contactButtonTapped() {
        print("")
    }
}

