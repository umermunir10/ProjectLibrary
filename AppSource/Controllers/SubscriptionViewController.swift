//
//  SubscriptionViewController.swift
//  projectLibrary
//
//  Created by Umer Munir on 22/08/2023.
//

import UIKit

class SubscriptionViewController: UIViewController {
    
    @IBOutlet var constraintCollection: [NSLayoutConstraint]!
    @IBOutlet var viewCollection: [UIView]!
    @IBOutlet var labelCollection: [UILabel]!
    @IBOutlet weak var subscriptionLabel: UILabel!
    @IBOutlet weak var subscriptionSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialiseBar()
        saveData()
        
    }
    
    func initialiseBar() {
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.title = "Subscription"
        self.navigationController?.navigationBar.tintColor = UIColor(named: "K10B269")
    }
    
    func saveData() {
        
        if let savedValue = UserDefaults.standard.value(forKey: "switchValue") as? Bool {
            subscriptionSwitch.isOn = savedValue
        }
        if let labelValue = UserDefaults.standard.value(forKey: "labelValue")
            as? String {
            subscriptionLabel.text = labelValue
        }
    }
    
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        
        if sender.isOn {
            subscriptionLabel.text = "Active"
        } else  {
            subscriptionLabel.text = "InActive"
        }
        
        UserDefaults.standard.set(sender.isOn, forKey: "switchValue")
        UserDefaults.standard.set(subscriptionLabel.text, forKey: "labelValue")
    }
}
