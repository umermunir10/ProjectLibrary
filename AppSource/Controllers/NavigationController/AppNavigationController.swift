//
//  AppNavigationController.swift
//  Kisma-iOS
//
//  Created by Mac  on 28/04/2022.
//

import UIKit

class AppNavigationController: UINavigationController {
    
    // MARK:- IBOutlets
    /// name should be in the format "viewTypeName" e.g. labelAge
    @IBOutlet var constraintCollection: [NSLayoutConstraint]!
    @IBOutlet var labelCollection: [UILabel]!
    @IBOutlet var buttonCollection: [UIButton]!
    @IBOutlet var textFieldCollection: [UITextField]!
    
    // MARK:- Internal Variables
    
    var didLoadViews = false
    
    // MARK:- Extternal Variables
    
    
    // MARK:- Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialiseVariables()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !self.didLoadViews {
            self.didLoadViews = true
            configureViews()
        }
    }
    
    // MARK:- Custom Methods
    
    func initialiseVariables() {
        
    }
    
    func configureViews() {
        /*
         self.view.layoutIfNeeded()
         for constraint in self.constraintCollection {
         constraint.resize()
         }
         
         for label in self.labelCollection {
         label.font = UIFont.setFont(withFontFamily: label.font.fontName, withSize: label.font.pointSize)
         }
         
         for button in self.buttonCollection {
         button.titleLabel?.font = UIFont.setFont(withFontFamily: button.titleLabel!.font.fontName, withSize: button.titleLabel!.font.pointSize)
         }
         
         for textField in self.textFieldCollection {
         textField.font = UIFont.setFont(withFontFamily: textField.font!.fontName, withSize: textField.font!.pointSize)
         }
         */
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = #colorLiteral(red: 0.949000001, green: 0.949000001, blue: 0.949000001, alpha: 1)
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
    }
    
    // MARK:- Navigation Methods
}

// MARK:- IBActions

extension AppNavigationController {
    // Actions name should be like "eventViewTypeAction" e.g. "backButtonAction"
}

// MARK:- Networking

extension AppNavigationController {
    
}
