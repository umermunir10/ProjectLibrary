//  ProfileViewController.swift
//  projectLibrary
//
//  Created by Umer Munir on 15/08/2023.

import UIKit
import SafariServices

class ProfileViewController: UIViewController {
    
    @IBOutlet var constraintCollection: [NSLayoutConstraint]!
    @IBOutlet var labelCollection: [UILabel]!
    @IBOutlet var viewCollection: [UIView]!
    @IBOutlet weak var profileTableView: UITableView!
    
    public var settingsMenu = Menu.settings
    public var infoMenu = Menu.info
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.profileTableView.delegate = self
        self.profileTableView.dataSource = self
        
        profileTableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileTableViewCell")
//        profileTableView.register(UINib(nibName: "HeaderViewCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // *MARK :- SETTINGS MENU
    
    func goToReadingGoalVC() {
        
        let vc = ReadingGoalViewController.instantiate(storyboard: .Main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToClearCacheVC() {
        
        let vc = ClearCacheViewController.instantiate(storyboard: .Main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToSubscriptionVC() {
        
        let vc = SubscriptionViewController.instantiate(storyboard: .Main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // *MARK :- INFO MENU
    
    func goToAboutVC() {
        
        let vc = AboutViewController.instantiate(storyboard: .Main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToPrivacyPolicy() {
        
        guard let url = URL(string: "https://www.imtbooks.com/privacy-policy-cookie-restriction-mode") else { return }
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)
    }
    
    func goToTermsandConditions() {
        
        guard let url = URL(string: "https://www.imtbooks.com/hamqadam-terms-and-conditions") else { return }
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)
    }
    
    func shareAppWithFriends(){
        let text = "You can find out Hamqadam on following link."
        guard let url : NSURL = NSURL(string: "https://apps.apple.com/us/app/hamqadam/id1633238263") else { return }
        
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [text, url], applicationActivities: nil)
        
        activityViewController.activityItemsConfiguration = [
            UIActivity.ActivityType.message
        ] as? UIActivityItemsConfigurationReading
        
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.postToTencentWeibo,
            UIActivity.ActivityType.postToFacebook
        ]
        
        activityViewController.isModalInPresentation = true
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func goToContactUsVC() {
        
        let vc = ContactUsViewController.instantiate(storyboard: .Main)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func deleteAccount() {
        let deleteAction = UIAlertAction(title: "Delete", style: .default) { (action) -> Void in
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) -> Void in
            
        }
        
        Utilities.showAlertWithTitle(title: "Hamqadam", alertMessage: "Are you sure you want to delete the account?", actions: [cancelAction, deleteAction])
    }
    
    func logout() {
        
        let logoutAction = UIAlertAction(title: "Logout", style: .default) { (action) -> Void in
            
            let vc = LoginViewController.instantiate(storyboard: .Main)
            self.navigationController?.pushViewController(vc, animated: true)
            CacheManager.shared.userProfile = nil
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) {
            (action) -> Void in
        }
        
        Utilities.showAlertWithTitle(title: "Hamqadam", alertMessage: "\n Are you sure you want to logout?", actions: [cancelAction , logoutAction])
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? settingsMenu.count : infoMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = profileTableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
        if indexPath.section == 0 {
            cell.titleLabel.text = settingsMenu[indexPath.row].rawValue
        } else if indexPath.section == 1 {
            cell.titleLabel.text = infoMenu[indexPath.row].rawValue
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            
            switch settingsMenu[indexPath.row] {
            case.SetGoal:
                goToReadingGoalVC()
                
            case.ClearCache:
                goToClearCacheVC()
                
            case.Subscription:
                goToSubscriptionVC()
                
            default:
                break
            }
        } else {
            
            switch infoMenu[indexPath.row] {
                
            case.About:
                goToAboutVC()
                
            case.PrivacyPolicy:
                goToPrivacyPolicy()
                
            case.TermsAndConditions:
                goToTermsandConditions()
                
            case.ShareWithAFriend:
                shareAppWithFriends()
                
            case.ContactUs:
                goToContactUsVC()
                
            case.DeleteAccount:
                deleteAccount()
                
            case.Logout:
                logout()
                
            default:
                break
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return section == 0 ? "Settings" : "Info"
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = profileTableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderViewCell") as? HeaderViewCell
//        header?.titleLabel.text = section == 0 ? "Settings" : "Info"
//        return header
//    }
}
