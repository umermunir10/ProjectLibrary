//
//  ClearCacheViewController.swift
//  projectLibrary
//
//  Created by Umer Munir on 22/08/2023.
//

import UIKit

class ClearCacheViewController: UIViewController {

    
    @IBOutlet var constraintCollection: [NSLayoutConstraint]!
    
    @IBOutlet var viewCollection: [UIView]!
    
    @IBOutlet var buttonCollection: [UIButton]!
    
    @IBOutlet var labelCollection: [UILabel]!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.title = "Clear Cache"
        
//        self.navigationController?.navigationBar.titleTextAttributes = attributes
//        let attributes = [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 24)]
        
    }
}
