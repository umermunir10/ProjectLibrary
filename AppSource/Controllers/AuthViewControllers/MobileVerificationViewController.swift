//  MobileVerificationViewController.swift
//  projectLibrary
//
//  Created by Umer Munir on 08/08/2023.

import UIKit

class MobileVerificationViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var viewCollection: [UIView]!
    @IBOutlet var labelCollection: [UILabel]!
    @IBOutlet var buttonCollection: [UIButton]!
    @IBOutlet var constraintCollection: [NSLayoutConstraint]!
    @IBOutlet weak var verifyView: UIView!
    @IBOutlet weak var goNextView: UIView!
    @IBOutlet var textFieldCollection: [UITextField]!
    @IBOutlet weak var textFieldVerifyCode1: UITextField!
    @IBOutlet weak var textFieldVerifyCode2: UITextField!
    @IBOutlet weak var textFieldVerifyCode3: UITextField!
    @IBOutlet weak var textFieldVerifyCode4: UITextField!
    
    var phoneNumber: String?
    var serviveHandler: NetworkServiceDelegate = NetworkManagerService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        iniitialiseVariables()
        self.verifyView.layer.cornerRadius = 10
        self.goNextView.layer.cornerRadius = goNextView.frame.size.width/2
        
    }
    
    func iniitialiseVariables() {
        
        self.textFieldVerifyCode1.delegate = self
        self.textFieldVerifyCode2.delegate = self
        self.textFieldVerifyCode3.delegate = self
        self.textFieldVerifyCode4.delegate = self
        textFieldVerifyCode1.becomeFirstResponder()
    }
    
    func moveToUserProfileViewController(profileData: UserProfile) {
        DispatchQueue.main.async {
            let vc = UserProfileViewController.instantiate(storyboard: .Main)
            vc.userProfile = profileData
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
        //        let vc = storyboard?.instantiateViewController(withIdentifier: "UserProfileViewController") as! UserProfileViewController
        //        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if !(string == "") {
            textField.text = string
            if textField == textFieldVerifyCode1 {
                textFieldVerifyCode2.becomeFirstResponder()
            }
            else if textField == textFieldVerifyCode2 {
                textFieldVerifyCode3.becomeFirstResponder()
            }
            else if textField == textFieldVerifyCode3 {
                textFieldVerifyCode4.becomeFirstResponder()
            }
            else if textField == textFieldVerifyCode4 {
                textFieldVerifyCode4.becomeFirstResponder()
            }
            else {
                textField.resignFirstResponder()
            }
            return false
        }
        else {
            if textField == textFieldVerifyCode4 {
                textFieldVerifyCode4.text = ""
                textFieldVerifyCode3.becomeFirstResponder()
            }
            else if textField == textFieldVerifyCode3 {
                textFieldVerifyCode3.text = ""
                textFieldVerifyCode2.becomeFirstResponder()
            }
            else if textField == textFieldVerifyCode2 {
                textFieldVerifyCode2.text = ""
                textFieldVerifyCode1.becomeFirstResponder()
            }
            else {
                textFieldVerifyCode1.text = ""
                textFieldVerifyCode1.becomeFirstResponder()
                // textField.resignFirstResponder()
            }
            return false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textFieldVerifyCode1.resignFirstResponder()
        textFieldVerifyCode2.resignFirstResponder()
        textFieldVerifyCode3.resignFirstResponder()
        textFieldVerifyCode4.resignFirstResponder()
    }
    
    @IBAction func goNextButton(_ sender: Any) {
        //print("Button is Pressed")
        var userEnterCode = ""
        for textField in self.textFieldCollection {
            userEnterCode+=textField.text!
        }
        //        let vc = UserProfileViewController.instantiate(storyboard: .Main)
        //        self.navigationController?.pushViewController(vc, animated: true)
        
        guard let phoneNo = self.phoneNumber else { return }
        
        if userEnterCode.count == 4 {
            phoneNumberVerificationCall(phoneNumber: phoneNo, code: userEnterCode)
        } else {
            
        }
        
        //
        //        var request = URLRequest(url: URL(string: "https://staginglibrary.6lgx.com/api/codeverification")!,timeoutInterval: Double.infinity)
        //        request.httpMethod = "POST"
        //
        //        let task = URLSession.shared.dataTask(with: request) { data, response, error in
        //            guard let data = data else {
        //                print(String(describing: error))
        //                return
        //            }
        //            print(String(data: data, encoding: .utf8)!)
        //        }
        //
        //        task.resume()
        //
        //        moveToUserProfileViewController()
    }
    
    @IBAction func resendCodeButton(_ sender: Any) {
        
        if let phoneNumber = phoneNumber {
            resendCode(phoneNumber: phoneNumber)
        }
    }
}

extension MobileVerificationViewController {
    
    func phoneNumberVerificationCall(phoneNumber: String , code: String) {
        
        serviveHandler.getVerifiedAndProfileData(phoneNumber: phoneNumber, code: code, completion: { result in
            switch result {
            case.success(let response):
                if let status = response.status {
                    if status {
                        guard let profileData = response.userProfile else { return }
                        self.moveToUserProfileViewController(profileData: profileData)
                        print(response.message)
                        print(response.userProfile?.name)
                    } else {
                        Utilities.showAlert(title: Messages.alert, alertMessage: response.message, actions: (Messages.ok, .default))
                    }
                }
            case.failure(let error):
                Utilities.showAlert(title: Messages.error, alertMessage: error.localizedDescription, actions: (Messages.ok, .default))
            }
        })
    }
    
    func resendCode(phoneNumber: String) {
        
        serviveHandler.getSignedUp(phoneNumber: phoneNumber, completion: { result in
            switch result {
            case.success(let response):
                if let status = response.status {
                    if status {
                        Utilities.showAlert(title: Messages.alert, alertMessage: "Verfication Code has been sent agian on \(phoneNumber)", actions: (Messages.ok, .default))
                        print(response.code)
                    } else {
                        Utilities.showAlert(title: Messages.alert, alertMessage: response.message, actions: (Messages.ok, .default))
                    }
                }
            case.failure(let error):
                Utilities.showAlert(title: Messages.alert, alertMessage: error.localizedDescription, actions: (Messages.ok, .default))
            }
        })
    }
}
