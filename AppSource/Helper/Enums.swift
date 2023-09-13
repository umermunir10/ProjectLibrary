//
//  Enums.swift
//  LibraryApp
//
//  Created by Faraz on 12/11/2021.
//

import UIKit
import Foundation

enum Storyboard : String {
    
    case LaunchScreen, Main ,Auth, Temp
    
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
        let storyboardID = "\(viewControllerClass as UIViewController.Type)"
        return instance.instantiateViewController(withIdentifier: storyboardID) as! T
    }
    
    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}

enum DeploymentEnvironment: String {
    case staging
    case qa
    case dev
    case live
}

extension NSNotification.Name {
    static let sideMenuTapped = NSNotification.Name(rawValue: "profileTapped")
    static let validateReceipt = NSNotification.Name(rawValue: "validateReceipt")
}

enum RecieptValidation: Int {
    case success
    case failure
    case productionFailed
}

enum Menu: String {
    
    case SetGoal = "Set Reading Goal"
    case ClearCache = "Clear Cache"
    case Subscription = "Subscription"
    case RestorePurchase = "Restore Purchases"
    
    case About = "About"
    case PrivacyPolicy = "Privacy Policy"
    case TermsAndConditions = "Terms and Conditions"
    case RateApp = "Rate App"
    case FAQ = "FAQ"
    case ShareWithAFriend = "Share With A Friend"
    case ContactUs = "Contact Us"
    case DeleteAccount = "Delete Account"
    case Logout = "Logout"
    
    static let settings = [SetGoal , ClearCache, Subscription]
    static let info = [About, PrivacyPolicy, TermsAndConditions, ShareWithAFriend, ContactUs, DeleteAccount, Logout]
}

enum RoundedCellType {
    case first
    case last
    case single
    case middle
}

//extension Bundle {
//    var releaseVersionNumber: String? {
//        return infoDictionary?["CFBundleShortVersionString"] as? String
//    }
//    var buildVersionNumber: String? {
//        return infoDictionary?["CFBundleVersion"] as? String
//    }
//}

//extension UIButton {
//
//    open override func awakeFromNib() {
//        self.titleLabel?.font = self.titleLabel?.font.withSize((self.titleLabel?.font.pointSize.relativeToIphone8Width())!)
//    }
//
//}

//let minScalableValue: CGFloat = 8.0 // Min value that should undergo upper scaling for bigger iphones and iPads
//extension CGFloat {
//
//    func relativeToIphone8Width(shouldUseLimit: Bool = true) -> CGFloat {
//        let upperScaleLimit: CGFloat = 1.8
//        var toUpdateValue = floor(self * (UIScreen.main.bounds.width / 375))
//        guard self > minScalableValue else {return toUpdateValue}
//        guard shouldUseLimit else {return toUpdateValue}
//        guard upperScaleLimit > 1 else {return toUpdateValue}
//        let limitedValue = self * upperScaleLimit
//        if toUpdateValue > limitedValue {
//            toUpdateValue = limitedValue
//        }
//        return toUpdateValue
//    }
//
//    func relativeToIphone8Height(shouldUseLimit: Bool = true) -> CGFloat {
//        var extraHeight: CGFloat = 0
//        if #available(iOS 11.0, *) {
//            extraHeight = UIApplication.shared.key?.safeAreaInsets.bottom ?? 0
//            extraHeight = extraHeight + (UIApplication.shared.key?.safeAreaInsets.top ?? 20) - 20
//        }
//        let upperScaleLimit: CGFloat = 1.8
//        var toUpdateValue = floor(self * ((UIScreen.main.bounds.height - extraHeight) / 667))
//        guard self > minScalableValue else {return toUpdateValue}
//        guard shouldUseLimit else {return toUpdateValue}
//        guard upperScaleLimit > 1 else {return toUpdateValue}
//        let limitedValue = self * upperScaleLimit
//        if toUpdateValue > limitedValue {
//            toUpdateValue = limitedValue
//        }
//        return toUpdateValue
//    }
//}
