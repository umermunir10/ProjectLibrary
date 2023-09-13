//
//  BookDetailsViewController.swift
//  projectLibrary
//
//  Created by Umer Munir on 29/08/2023.
//

import UIKit

class BookDetailsViewController: UIViewController {

    @IBOutlet var constraintCollection: [NSLayoutConstraint]!
    @IBOutlet var buttonCollection: [UIButton]!
    @IBOutlet var viewCollection: [UIView]!
    @IBOutlet var labelCollection: [UILabel]!
    
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
}
