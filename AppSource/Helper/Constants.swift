//
//  Constants.swift
//  LibraryApp
//
//  Created by Faraz on 12/11/2021.
//

import UIKit

let currentEnvironment: DeploymentEnvironment = .dev
let appVersionDisplayString = "V \(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String) \(currentEnvironment != .live ? currentEnvironment.rawValue.capitalized : "")"

extension UIScreen {
    var physicalHeight:CGFloat  {
        return bounds.height*scale
    }
}

//struct Screen {
//    static let width = UIApplication.shared.key?.bounds.width ?? UIWindow().bounds.width
//    static let height = UIApplication.shared.key?.bounds.height ?? UIWindow().bounds.height
//    static let designWidth: CGFloat = 375
//    static let sizeMultiplier = UIDevice.isPad && UIScreen.main.physicalHeight > 2600 ? 1.8 : UIDevice.isPad ? 1.5 : (UIScreen.main.bounds.width / Screen.designWidth)
//}

struct FontName {
    static let regular = "system"
    static let bold = "boldSystem"
}
struct CacheKeys {
    static let identifier: String = "identifier"
    static let profile: String = "userData"
    static let deviceTokenKey: String = "deviceTokenKey" // For USerDefaults
    static let cameraPopup: String = "cameraPopup"
}

struct Messages {
    static let internetError = NSLocalizedString("Internet connection appears to be offline.", comment: "")
    static let serverError = NSLocalizedString("Server is not responding.", comment: "")
    static let expiredSubscription = NSLocalizedString("Subscription Expired!", comment: "")
    static let alert = NSLocalizedString("Alert!", comment: "")
    static let error = NSLocalizedString("Error!", comment: "")
    static let ok = NSLocalizedString("Ok", comment: "")
    static let cancel = NSLocalizedString("Cancel", comment: "")
    static let settings = NSLocalizedString("settings", comment: "")
    static let settingsMessage = NSLocalizedString("Please enable it from settings", comment: "")
    static let cameraNotAvailableMessage = NSLocalizedString("Unable to found camera", comment: "")
    static let signOut = NSLocalizedString("Sign out", comment: "")
    static let signOutWithQuestionMark = NSLocalizedString("Sign out?", comment: "")
    static let continueMessage = NSLocalizedString("Continue", comment: "")
    static let logoutMessage = "Are you sure you want to sign out?\nYou can sign in again to access your content."
    static let iapReceiptValidationError = NSLocalizedString("Something went wrong. Please try again", comment: "")
    static let noSubscription = NSLocalizedString("No Subscription!", comment: "")
    static let noSubscriptionMessage = NSLocalizedString("Currently, you did not have any active subscription. Go to your profile and click on subscription to buy.", comment: "")
    static let noReadingMessage = NSLocalizedString("No magazine or book available for reading.", comment: "")
}

var OnSignalAppId: String {
    
    switch currentEnvironment {
    case .staging:
        return "ee176cae-9bf8-4f4a-8759-a19a497cf7e6"
    case .qa:
        return "ee176cae-9bf8-4f4a-8759-a19a497cf7e6"
    case .dev:
        return "ee176cae-9bf8-4f4a-8759-a19a497cf7e6"
    case .live:
        return "ee176cae-9bf8-4f4a-8759-a19a497cf7e6"
    }
}
