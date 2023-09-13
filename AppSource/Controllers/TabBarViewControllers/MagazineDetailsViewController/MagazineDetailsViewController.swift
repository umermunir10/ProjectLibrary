//
//  MagazineDetailsViewController.swift
//  projectLibrary
//
//  Created by Umer Munir on 29/08/2023.
//

import UIKit

class MagazineDetailsViewController: UIViewController {

    @IBOutlet var constraintCollection: [NSLayoutConstraint]!
    @IBOutlet var viewCollection: [UIView]!
    @IBOutlet var buttonCollection: [UIButton]!
    @IBOutlet var labelCollection: [UILabel]!
    
    var magazine: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
