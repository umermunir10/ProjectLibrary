//
//  ContactUsViewController.swift
//  projectLibrary
//
//  Created by Umer Munir on 22/08/2023.
//

import UIKit
import MessageUI

class ContactUsViewController: UIViewController, MFMailComposeViewControllerDelegate, UIGestureRecognizerDelegate {
    
    
    
    @IBOutlet var labelCollection: [UILabel]!
    @IBOutlet var textViewCollection: [UITextView]!
    @IBOutlet var buttonCollection: [UIButton]!
    @IBOutlet var viewCollection: [UIView]!
    @IBOutlet var constraintCollection: [NSLayoutConstraint]!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textView.layer.cornerRadius = 15
        self.sendButton.layer.cornerRadius = 20
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.title = "Contact Us"
        self.navigationController?.navigationBar.tintColor = UIColor(named: "K10B269")
    }
    
    func addTapGesture() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction func sendButton (_ sender: UIButton) {
        
        guard textView.text.count > 1 else { return }
        guard let feedback = textView.text else { return }
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["munirumer61@gmail.com"])
            mail.setMessageBody(feedback, isHTML: false)
            present(mail, animated: true)
        } else {
            print("Show Failure Alert")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

extension ContactUsViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
