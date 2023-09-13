//  ViewController.swift
//  projectLibrary
//
//  Created by Umer Munir on 04/08/2023.

import UIKit
import CountryPicker
import Foundation
import SafariServices

class LoginViewController: UIViewController {
    
    @IBOutlet var labelCollection: [UILabel]!
    @IBOutlet var buttonCollection: [UIButton]!
    @IBOutlet var viewCollection: [UIView]!
    @IBOutlet var textFieldCollection: [UITextField]!
    @IBOutlet var constraintCollection: [NSLayoutConstraint]!
    
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var nextView: UIView!
    @IBOutlet weak var imageViewCountryFlag: UIImageView!
    @IBOutlet weak var labelCountryCode: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    var serviceHandler: NetworkServiceDelegate = NetworkManagerService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginView.layer.cornerRadius = 10
        self.nextView.layer.cornerRadius = nextView.frame.size.width/2
        self.errorLabel.text = ""
        
    }
    
    func moveToVerificationViewController(phoneNumber: String) {
        DispatchQueue.main.async {
            let vc = MobileVerificationViewController.instantiate(storyboard: .Main)
            vc.phoneNumber = phoneNumber
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
        //        let vc = storyboard?.instantiateViewController(withIdentifier: "MobileVerificationViewController") as! MobileVerificationViewController
        //        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func selectCountryButton(_ sender: Any) {
        
        CountryPickerWithSectionViewController.presentController(on: self) { [weak self] (country: Country) in
            
            guard let self = self else { return }
            // add country code into user defaults via optional model
            
            self.imageViewCountryFlag.image = country.flag
            self.labelCountryCode.text = country.dialingCode
        }
        print("Hello")
    }
    
    
    @IBAction func openTermsAndConditions(_ sender: Any) {
        
        guard let url = URL(string: "https://www.imtbooks.com/hamqadam-terms-and-conditions") else { return }
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)
    }
    
    @IBAction func goNextButton(_ sender: Any) {
        
        if self.phoneNumberTextField.text == "" {
            self.errorLabel.text = "Phone Number Cannot be Empty"
        }
        else if !self.phoneNumberTextField.text!.isAllDigits() {
            self.errorLabel.text = "Phone Number should contain only Digits"
        }
        else if !self.phoneNumberTextField.text!.isValidPhoneNumber() {
            self.errorLabel.text = "Invalid Phone Number"
        }
        else  {
            self.errorLabel.text = ""
            getSignedUp(phoneNumber: (self.labelCountryCode.text! + self.phoneNumberTextField.text!).trimmed)
            // self.moveToVerificationViewController()
            
            
        }
        
        //        var request = URLRequest(url: URL(string: "https://staginglibrary.6lgx.com/api/signup")!,timeoutInterval: Double.infinity)
        //
        //        request.httpMethod = "POST"
        //
        //        let task = URLSession.shared.dataTask(with: request) { data, response, error in
        //            guard let data = data else {
        //                print(String(describing: error))
        //                return
        //            }
        //            print(String(data: data, encoding: .utf8)!)
        //        }
        //        task.resume()
    }
}

extension LoginViewController {
    
    func getSignedUp(phoneNumber: String) {
        
        serviceHandler.getSignedUp(phoneNumber: phoneNumber, completion: { result in
            switch result {
            case.success(let response):
                if let status = response.status {
                    if status {
                        self.moveToVerificationViewController(phoneNumber: phoneNumber)
                       print(response.code)
                    } else {
                        Utilities.showAlert(title: Messages.alert, alertMessage: response.message, actions: (Messages.ok, .default))
                    }
                }
            case.failure(let error):
                Utilities.showAlert(title: Messages.error, alertMessage: error.localizedDescription, actions: (Messages.ok, .default))
            }
        })
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.phoneNumberTextField.resignFirstResponder()
    }
}
