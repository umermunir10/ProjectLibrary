////
////  UIFont.swift
////  LibraryApp
////
////  Created by Faraz on 15/11/2021.
////
//
//import Foundation
//import UIKit
//
//extension UIFont {
//    
////    class func setFont(withFontFamily font: String, withSize size: CGFloat) -> UIFont {
////        let multiplier = UIDevice.isPad && UIScreen.main.physicalHeight > 2600 ? 1.4 : UIDevice.isPad ? 1.3 : (UIScreen.main.bounds.width / Screen.designWidth)
////        let modifiedSize = size * multiplier
////        return UIFont(name: font, size: modifiedSize)!
////    }
//}
//
//extension UIFont {
//    
//    public enum SFProTextType: String {
//        
//        case regular = "-Regular"
//        case italic = "-Italic"
//        case light = "-Light"
//        case lightItalic = "-LightItalic"
//        case medium  = "-Medium"
//        case mediumItali = "-MediumItali"
//        case semiBold = "-Semibold"
//        case semiboldIta  = "-SemiboldIta"
//        case bold  = "-Bold"
//        case boldItalic  = "-BoldItalic"
//        case heavy  = "-Heavy"
//        case heavyItalic  = "-HeavyItalic"
//    }
//    
//    class func SFProText(_ type: SFProTextType = .regular, withSize size: CGFloat) -> UIFont {
////        let modifiedSize = size * Screen.sizeMultiplier
//        return UIFont(name: "SFProText\(type.rawValue)", size: modifiedSize)!
//    }
//    
//}
