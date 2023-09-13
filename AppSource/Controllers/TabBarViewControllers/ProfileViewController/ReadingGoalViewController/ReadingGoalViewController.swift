//
//  ReadingGoalViewController.swift
//  projectLibrary
//
//  Created by Umer Munir on 22/08/2023.
//

import UIKit

class ReadingGoalViewController: UIViewController {
    
    @IBOutlet var constraintCollection: [NSLayoutConstraint]!
    
    
    @IBOutlet var labelCollection: [UILabel]!
    @IBOutlet var viewCollection: [UIView]!
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var numberSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Reading Goals"
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.tintColor = UIColor(named: "K10B269")
        
        numberSlider.minimumValue = 0
        numberSlider.maximumValue = 180
        numberLabel.text = "0 Minutes"
        
        if let savedValue = UserDefaults.standard.value(forKey: "sliderValue") as? Float {
            numberSlider.value = savedValue
            numberLabel.text = "\(Int(savedValue)) Minutes"
        }
        
    }
    
    @IBAction func sliderValuChanged(_ sender: UISlider) {
        
        let step: Float = 5.0
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        numberLabel.text = "\(Int(roundedValue)) Minutes"
        UserDefaults.standard.set(roundedValue, forKey: "sliderValue")
        
    }
}
