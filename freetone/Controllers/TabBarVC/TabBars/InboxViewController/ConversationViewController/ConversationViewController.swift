//
//  ConversationViewController.swift
//  freetone
//
//  Created by Mac on 02/12/2024.
//

import UIKit
import MessageUI

//MARK: - UI -
class ConversationViewController: BaseViewController {
    
    //MARK: - Objects -
    var message: Message?
    
    var conversationMessages: [Message] = []
   
    public lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0/255, green: 255/255, blue: 230/255, alpha: 1.0)
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    public lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0/255, green: 255/255, blue: 230/255, alpha: 1.0)
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.text = ""
        return label
    }()
    
    fileprivate lazy var messageView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.backgroundColor = .gray
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 8
        return textView
    }()
    
    let sendButton = Button(image: UIImage(systemName: ""), text: "Send", btnTitleColor: UIColor(red: 0/255, green: 255/255, blue: 230/255, alpha: 1.0), backgroundColor: .clear, radius: 0, imageColor: .clear, borderWidth: 0, borderColor: UIColor(red: 0/255, green: 255/255, blue: 230/255, alpha: 1.0).cgColor)
    
    //MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        setSubviewsAndLayout()
    }
    
    //MARK: - Update time -
    func updateUI() {
        if let message = message {
            messageLabel.text = message.messageBody
            let formattedTime = message.time.formatTime(from: message.time)
            timeLabel.text = formattedTime
        }
    }
    
    // MARK: - Subviews and Layout -
    func setSubviewsAndLayout() {
        view.addSubview(messageLabel)
        view.addSubview(timeLabel)
        view.addSubview(messageView)
        view.addSubview(sendButton)
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 20),
            messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            messageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            messageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            messageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            messageView.heightAnchor.constraint(equalToConstant: 200),
            
            sendButton.topAnchor.constraint(equalTo: messageView.bottomAnchor, constant: 20),
            sendButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            sendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            timeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
    }
    
    func updateConversation(with newMessage: Message) {
        conversationMessages.append(newMessage)
        
        let formattedMessage = "\(newMessage.messageBody) \(newMessage.time.formatTime(from: newMessage.time))"
        
        if let existingMessage = messageLabel.text {
            messageLabel.text = existingMessage + "\n\n" + formattedMessage
        } else {
            messageLabel.text = formattedMessage
        }
    }
    
    //MARK: -
    @objc func sendMessage() {
        let messageBody = messageView.text ?? ""
        let currentTime = String(Date().timeIntervalSince1970)
        
        guard let recipientPhoneNumber = message?.recipientPhoneNumber else {return}
        let message = Message(senderPhoneNumber: "user", recipientPhoneNumber: recipientPhoneNumber, messageBody: messageBody, time: currentTime, id: "")
        
        Task {
            if let savedMessages = await DatabaseManager.shared.saveMessage(message: message) {
                DispatchQueue.main.async {
                    self.updateConversation(with: savedMessages)
                }
            } else {
                print("failed to save message")
            }
        }
        
        #if targetEnvironment(simulator)
        showAlert(title: "Message sent", message: "This is a simulation. Message sent to")
        //resetMessageFields()
        #else
        
        if MFMessageComposeViewController.canSendText() {
            let messageController = MFMessageComposeViewController()
            messageController.body = messageBody
            messageController.recipients = [phoneNumber]
            messageController.messageComposeDelegate = self
            present(messageController, animated: true)
            
        } else {
            showAlert(title: "Error", message: "SMS is not available on this device")
        }
        #endif
    }
}

extension ConversationViewController: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true)
        switch result {
        case .sent:
            print("message sent successfully")
        case .failed:
            print("message sending failed")
        case .cancelled:
            print("message sending cancelled")
        default:
            break
        }
    }
}

