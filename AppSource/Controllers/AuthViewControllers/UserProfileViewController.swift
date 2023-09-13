//  UserProfileViewController.swift
//  projectLibrary
//  Created by Umer Munir on 10/08/2023.

import UIKit

class UserProfileViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet var viewCollection: [UIView]!
    @IBOutlet var labelCollection: [UILabel]!
    @IBOutlet var textFieldCollection: [UITextField]!
    @IBOutlet var contraintCollection: [NSLayoutConstraint]!
    @IBOutlet weak var userProfileView: UIView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var labelError: UILabel!
    @IBOutlet weak var imageViewUserProfile: UIImageView!
    
    var userProfile: UserProfile?
    var serviceHandler: NetworkServiceDelegate = NetworkManagerService()
    var picker = UIImagePickerController()
    var alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        intialiseVariables()
        self.userProfileView.layer.cornerRadius = 10
        self.labelError.text = ""
    }
    
    func intialiseVariables() {
        self.userNameTextField.delegate = self
        self.userNameTextField.text = self.userProfile?.name
        
//        if let imageURL = self.userProfile?.image {
//            self.imageViewUserProfile.setImage(url: imageURL)
//        } else {
//            self.imageViewUserProfile.image = UIImage(named: "CAMERA")
//        }
    }
    
//    func configureViews() {
//        
//        picker.delegate = self
//        let cameraAction = UIAlertAction(title: "Camera", style: .default){
//            UIAlertAction in
//           // self.openCamera()
//        }
//        let galleryAction = UIAlertAction(title: "Gallery", style: .default){
//            UIAlertAction in
//            self.openGallery()
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: .default){
//            UIAlertAction in
//        }
//        alert.addAction(cameraAction)
//        alert.addAction(galleryAction)
//        alert.addAction(cancelAction)
//    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let allowedCharacters = CharacterSet.letters
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    @IBAction func openCameraButton(_ sender: Any) {
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func goNextButton(_ sender: Any) {
        
        if userNameTextField.text?.count == 0 {
            labelError.text = "Name Cannot Be Empty"
        }
        else {
            self.labelError.text = ""
            if let id = self.userProfile?.id, let name = self.userNameTextField.text, let data = self.imageViewUserProfile.image?.jpegData(compressionQuality: 0.25) { self.updateProfileData(name: name, userID: id, imageData: data)
            }
        }
    }
}

extension UserProfileViewController {
    
    func updateProfileData(name: String, userID: Int, imageData: Data?) {
        serviceHandler.updateProfileData(name: name, userId: userID, imageData: imageData, completion: { result in
            switch result {
            case.success(let response):
                if let status = response.status {
                    if status {
                        if var userProfile = response.userProfile {
                            if let subscribedBooks = response.subscribedBooks {
                                let bookIds = subscribedBooks.map({($0.bookId ?? 0)})
                                userProfile.subscribedBooks = bookIds
                                CacheManager.shared.userProfile = userProfile
                            } else {
                                CacheManager.shared.userProfile = userProfile
                            }
                            DispatchQueue.main.async {
                                SceneDelegate.shared.moveToHomeScreen()
                                print(response.userProfile?.name)
                            }
                        }
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

extension UserProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
//    func openCamera() {
//
//        alert.dismiss(animated: true, completion: nil)
//        if(UIImagePickerController.isSourceTypeAvailable(.camera)) {
//            picker.sourceType = .camera
//            self.present(picker, animated: true, completion: nil)
//        } else {
//            let alertController = UIAlertController = {
//                let controller = UIAlertController(title: "Warninig", message: "You do not have camera", preferredStyle: .alert)
//                let action = UIAlertAction(title: "OK", style: .default)
//                controller.addAction(action)
//                return controller
//            }()
//            self.present(alertController, animated: true)
//        }
//    }
    
//    func openGallery() {
//
//        alert.dismiss(animated: true, completion: nil)
//        picker.sourceType = .photoLibrary
//        self.present(picker, animated: true, completion: nil)
//    }
//
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//
//        picker.dismiss(animated: true, completion: nil)
//    }
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        picker.dismiss(animated: true, completion: nil)
//        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            self.imageViewUserProfile.image = image
//        }
//    }
}
