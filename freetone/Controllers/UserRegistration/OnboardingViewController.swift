//
//  OnboardingViewController.swift
//  freetone
//
//  Created by Mac on 20/11/2024.
//

import UIKit
//MARK: - UI -
class OnboardingViewController: UIViewController, UIScrollViewDelegate {
    
    //MARK: - Objects -
    ////UIImageView
    fileprivate lazy var appLogo: UIImageView = {
        let logo = UIImageView(image: UIImage(named: "logo"))
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.tintColor = UIColor(red: 0/255, green: 255/255, blue: 230/255, alpha: 1.0)
        logo.contentMode = .scaleAspectFit
        return logo
    }()
    
    ////LABEL
    fileprivate lazy var appLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "FreeTone"
        label.textColor = UIColor(red: 0/255, green: 255/255, blue: 230/255, alpha: 1.0)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    ////BUTTON
    fileprivate lazy var getPhoneNumberBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Get a phone number", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = UIColor(red: 0/255, green: 255/255, blue: 230/255, alpha: 1.0)
        btn.layer.cornerRadius = 8
        return btn
    }()
    
    ////BUTTON
    fileprivate lazy var loginBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Log in", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 8
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor(red: 0/255, green: 255/255, blue: 230/255, alpha: 1.0).cgColor
        return btn
    }()
    
    ////LABEL
    fileprivate lazy var privacyPolicyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "By using Freetone, you agree with the Terms & \n Conditions, and the Privacy Policy."
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        return label
    }()
    
    ////STACKVIEW
    fileprivate lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [appLogo, appLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = -80
        stack.alignment = .center
        return stack
    }()
    
    ////SCROLLVIEW
    let scrollView = UIScrollView()
    
    ////PAGECONTROL
    let pageControl = UIPageControl()
    
    let imageLogos = ["logo2", "logo3", "logo4"]
    let pageTexts = ["Get your local phone number", "Group chat, voicemail, send pics &\n much more", "Reach anyone in the world with\n affordable international rates"]
    
    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        configureScrollView()
    }
    
    //MARK: - Configure scrollview with its properties and subviews -
    func configureScrollView() {
        scrollView.frame = view.bounds
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = CGSize(width: view.bounds.width * CGFloat(imageLogos.count), height: 100)
        
        for (index, imageLogo) in imageLogos.enumerated() {
            let imageView = UIImageView(frame: CGRect(x: view.bounds.width * CGFloat(index), y: 100, width: UIScreen.main.bounds.width, height: 200))
            imageView.image = UIImage(named: imageLogo)
            imageView.contentMode = .scaleAspectFit
            scrollView.addSubview(imageView)
            
            
            let label = UILabel(frame: CGRect(x: view.bounds.width * CGFloat(index), y: 290, width: UIScreen.main.bounds.width, height: 80))
            label.text = pageTexts[index]
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            label.textColor = .white
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            label.adjustsFontSizeToFitWidth = true
            scrollView.addSubview(label)
        }
        view.addSubview(scrollView)
        configurePageControl()
        setSubviewsAndLayout()
    }
    
    //MARK: - Configure page control with its properties -
    func configurePageControl() {
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .lightGray
        pageControl.pageIndicatorTintColor = UIColor(red: 0/255, green: 255/255, blue: 230/255, alpha: 1.0)
        pageControl.frame = CGRect(x: 0, y: 450, width: view.frame.size.width, height: 50)
        view.addSubview(pageControl)
        pageControlSelectedAction()
        //configureAppLogo()
    }
    
    //MARK: - This action when tapped shows each page control.
    func pageControlSelectedAction() {
        let action = UIAction { [weak self] _ in
            self?.pageControlTapped(self!.pageControl)
        }
        pageControl.addAction(action, for: .primaryActionTriggered)
    }
    
    //MARK: - function that shows each page control
    func pageControlTapped(_ sender: UIPageControl) {
        let currentPage = pageControl.currentPage
        let xOffset = view.bounds.width * CGFloat(currentPage)
        scrollView.setContentOffset(CGPoint(x: xOffset, y: 50), animated: false)
    }
    
    //MARK: - Scrollview Protocol Methods for scrolling the page control
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.bounds.width)
        pageControl.currentPage = Int(pageIndex)
    }
    
    // MARK: - Subviews and Layout -
    func setSubviewsAndLayout() {
        let subViews = [stackView, getPhoneNumberBtn, loginBtn, privacyPolicyLabel]
        for subView in subViews {
            view.addSubview(subView)
        }
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            appLogo.widthAnchor.constraint(equalToConstant: 80),
            appLogo.heightAnchor.constraint(equalToConstant: 50),
            
            getPhoneNumberBtn.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 380),
            getPhoneNumberBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            getPhoneNumberBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            getPhoneNumberBtn.heightAnchor.constraint(equalToConstant: 50),
            
            loginBtn.topAnchor.constraint(equalTo: getPhoneNumberBtn.bottomAnchor, constant: 20),
            loginBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            loginBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            loginBtn.heightAnchor.constraint(equalToConstant: 50),
            
            privacyPolicyLabel.topAnchor.constraint(equalTo: loginBtn.bottomAnchor, constant: 20),
            privacyPolicyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            privacyPolicyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
        loginBtn.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    @objc func loginButtonTapped() {
        let vc = SignInViewController()
        navigationController?.pushViewController(vc, animated: false)
    }
}
