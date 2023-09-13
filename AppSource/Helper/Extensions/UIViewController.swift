//
//  UIViewController.swift
//  projectLibrary
//
//  Created by Umer Munir on 15/08/2023.
//

import UIKit
import Foundation

extension UIViewController {
    
    static func instantiate(storyboard: Storyboard) -> Self {
        return storyboard.viewController(viewControllerClass: self)
    }
}
