//
//  BannerView.swift
//  LibraryApp
//
//  Created by Faraz on 15/11/2021.
//

import UIKit

class BannerView: UIView {
    
    // MARK:- IBOutlets
    /// name should be in the format "viewTypeName" e.g. labelAge
    @IBOutlet var constraintCollection: [NSLayoutConstraint]!
    @IBOutlet var labelCollection: [UILabel]!
    @IBOutlet var buttonCollection: [UIButton]!
    @IBOutlet var textFieldCollection: [UITextField]!
    
    @IBOutlet weak var labelErrorMessage: UILabel!
    
    // MARK:- Internal Variables
    
    fileprivate var view: UIView!
    
    // MARK:- Extternal Variables
    
    var errorMessage = "" {
        didSet {
            self.labelErrorMessage.text = errorMessage
        }
    }
    var dismissActionClosure: (() -> (Void))?
    
    //MARK:- Initializers
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    // MARK:- Overriden Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    // MARK:- Custom Methods
    
    private func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(view)
        //configureViews()
    }
    
    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: BannerView.self)
        let nib = UINib(nibName: "BannerView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
//    func configureViews() {
//
//        self.layoutIfNeeded()
//        for constraint in self.constraintCollection {
//            constraint.resize()
//        }
//
//        for label in self.labelCollection {
//            label.font = UIFont.setFont(withFontFamily: label.font.fontName, withSize: label.font.pointSize)
//        }
        
        /*
         for button in self.buttonCollection {
         button.titleLabel?.font = UIFont.setFont(withFontFamily: button.titleLabel!.font.fontName, withSize: button.titleLabel!.font.pointSize)
         }
         
         for textField in self.textFieldCollection {
         textField.font = UIFont.setFont(withFontFamily: textField.font!.fontName, withSize: textField.font!.pointSize)
         }
         */
    }
    
    //MARK:- IBActions
    /// Actions name should be like "eventViewTypeAction" e.g. "backButtonAction"
    
//    @IBAction func dismissButtonAction(_ sender: Any) {
//        self.dismissActionClosure?()
//    }
//}
