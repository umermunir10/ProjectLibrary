//  AboutViewController.swift
//  projectLibrary
//
//  Created by Umer Munir on 23/08/2023.

import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet var constraintCollection: [NSLayoutConstraint]!
    @IBOutlet var viewCollection: [UIView]!
    @IBOutlet weak var aboutTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialiseCell()
        initialiseBar()
        
    }
    
    func initialiseBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.title = "About Hamqadam"
        self.navigationController?.navigationBar.tintColor = UIColor(named: "K10B269")
    }
    
    func initialiseCell() {
        
        self.aboutTableView.register(UINib(nibName: "AboutTableViewCell", bundle: nil), forCellReuseIdentifier: "AboutTableViewCell")
    }
}

extension AboutViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = aboutTableView.dequeueReusableCell(withIdentifier: "AboutTableViewCell", for: indexPath) as! AboutTableViewCell
            cell.descriptionLabel.text = CacheManager.shared.userProfile?.name
            cell.informationLabel.text = CacheManager.shared.userProfile?.phone
            return cell
            
        } else if indexPath.row == 1 {
            let cell = aboutTableView.dequeueReusableCell(withIdentifier: "AboutTableViewCell", for: indexPath) as! AboutTableViewCell
            cell.descriptionLabel.text = "Hamqadam"
            cell.informationLabel.text = "Version 1.0.3 Build (1)"
            return cell
            
        } else if indexPath.row == 2 {
            let cell = aboutTableView.dequeueReusableCell(withIdentifier: "AboutTableViewCell", for: indexPath) as! AboutTableViewCell
            cell.descriptionLabel.text = "No Active Subscription Found"
            cell.informationLabel.text = ""
            return cell
            
        } else {
            let cell = aboutTableView.dequeueReusableCell(withIdentifier: "AboutTableViewCell", for: indexPath) as! AboutTableViewCell
            cell.descriptionLabel.text = "This application will have wide range of books and magazines readable only to subscribed users. Most of the literature is in Urdu language. The content will be related to all ages and genders specially from Pakistan but for all Urdu reading population across the globe."
            cell.informationLabel.text = ""
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        return UITableView.automaticDimension
    }
}
