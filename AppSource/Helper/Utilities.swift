//
//  Utilities.swift
//  LibraryApp
//
//  Created by Faraz on 12/11/2021.
//

import Foundation
import UIKit
import Lottie

class Utilities {
    
    static var loaderView: UIView?
    
    
    class var yyyyMMddHHmmss: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter
    }
    
    class var dayDateMonthFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E d MMM yyyy"
        return dateFormatter
    }
    
    class var dayDateMonthHHmmssFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E d MMM yyyy HH:mm:ss"
        return dateFormatter
    }
    
    class var dateMonthFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM"
        return dateFormatter
    }
    
    class var yearFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter
    }
    
    class var yyyyMMddFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }
    
    class func getLocalDateTime(dateTimeUTC: String) -> String? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss VV"
        
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let dt = dateFormatter.date(from: dateTimeUTC) {
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            return dateFormatter.string(from: dt)
        }
        return nil
    }
//    
//    static func setNoRecordView(_ noRecordText: String, tableView: UITableView, imageName: String = "LIBRARY GREEN") -> UIView {
//        let noRecordCustomView = NoRecord(frame: CGRect(x: 0, y: 0, width: tableView.visibleSize.width, height: tableView.visibleSize.height))
//        noRecordCustomView.setNoRecordText(noRecordText)
//        noRecordCustomView.setImageView(imageName: imageName)
//        return noRecordCustomView
//    }
    
    class func showAlert(title: String, alertMessage: String?, alertStyle: UIAlertController.Style = .alert, actions: (text: String, style: UIAlertAction.Style)..., controller: UIViewController? = nil, completion: ((_ index: Int) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: alertMessage ?? "Success", preferredStyle: alertStyle)
        for (index, action) in actions.enumerated() {
            let alertAction = UIAlertAction(title: action.text, style: action.style) { (_) in
                completion?(index)
            }
            alertController.addAction(alertAction)
        }
        
        if let controller = controller {
            controller.present(alertController, animated: true, completion: nil)
        }
        else {
            DispatchQueue.main.async {
                UIApplication.shared.key?.rootViewController?.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    class func showAlert(title: String, alertMessage: String, alertStyle: UIAlertController.Style = .alert, actions: (text: String, style: UIAlertAction.Style)..., controller: UIViewController? = nil, completion: ((_ index: Int) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: alertMessage, preferredStyle: alertStyle)
        for (index, action) in actions.enumerated() {
            let alertAction = UIAlertAction(title: action.text, style: action.style) { (_) in
                completion?(index)
            }
            alertController.addAction(alertAction)
        }
        
        if let controller = controller {
            controller.present(alertController, animated: true, completion: nil)
        }
        else {
            DispatchQueue.main.async {
                UIApplication.shared.key?.rootViewController?.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    class func showAlertWithTitle(title: String, alertMessage: String, actions: [UIAlertAction] = []) {
        let alert = UIAlertController(title: title, message: alertMessage, preferredStyle: .alert)
        
        for action in actions {
            alert.addAction(action)
        }
        
        if actions.count == 0 {
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        }
        DispatchQueue.main.async {
            UIApplication.shared.key?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    class func showNavigationAlert(_ error: URLError) {
        
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.key else { return }
            let alertViews = window.subviews.filter { $0 is BannerView }
            var bannerView: BannerView!
            
            if let alertView = alertViews.first as? BannerView {
                bannerView = alertView
            }
            else {
                bannerView = BannerView()
            }
            
//            if alertViews.first == nil {
//                bannerView.alpha = 0.0
//                bannerView.frame = CGRect(x: 0, y: 0, width: Screen.width, height: (44 * Screen.sizeMultiplier) + window.safeAreaInsets.top)
//                bannerView.dismissActionClosure = {
//                    self.dismissNavigationAlert()
//                }
//                window.addSubview(bannerView)
//            }
//            
//            switch error {
//                
//            case .internetError:
//                bannerView.errorMessage = Messages.internetError
//            case .authError, .decodingError:
//                bannerView.errorMessage = ""
//            case .noData, .timeOutError:
//                bannerView.errorMessage = Messages.serverError
//            case .badURL:
//                bannerView.errorMessage = Messages.serverError
//            }
//            
//            UIView.animate(withDuration: 0.5, animations: {
//                bannerView.alpha = 1.0
//            }, completion: nil)
        }
    }
    
    class func dismissNavigationAlert() {
        DispatchQueue.main.async {
            let alertViews = UIApplication.shared.key!.subviews.filter { $0 is BannerView }
            
            if let alertView = alertViews.first {
                alertView.alpha = 1.0
                UIView.animate(withDuration: 0.5, animations: {
                    alertView.alpha = 0.0
                }, completion: { _ in
                    alertView.removeFromSuperview()
                })
            }
        }
    }
    
    class func savePageNo(pageNo: Int) {
        UserDefaults.standard.setValue(pageNo, forKey: "PageNo")
    }
    
    class func getPageNo() -> Int {
        return UserDefaults.standard.integer(forKey: "PageNo")
    }
    
    class func showHUD() {
        DispatchQueue.main.async {
            guard UIApplication.shared.key?.subviews.filter({$0.tag == 432 }).first == nil else {
                return
            }
            
//            let animationHolderView = UIView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height))
//            animationHolderView.backgroundColor = .clear
//            animationHolderView.tag = 432
//            let animationView = AnimationView(name: "66999-loader")
//            animationView.backgroundColor = #colorLiteral(red: 0.851000011, green: 0.851000011, blue: 0.851000011, alpha: 1)
//            animationView.layer.cornerRadius = 10
//            animationView.clipsToBounds = true
//            animationView.frame = CGRect(x: 0, y: 0, width: 100 * Screen.sizeMultiplier, height: 100 * Screen.sizeMultiplier)
//            animationView.center = CGPoint(x: Screen.width/2, y: Screen.height/2)
//            animationView.loopMode = .loop
//            
//            animationHolderView.addSubview(animationView)
//            UIApplication.shared.key?.addSubview(animationHolderView)
//            animationView.play()
        }
    }
    
    class func hideHUD() {
        self.loaderView = nil
        DispatchQueue.main.async {
            UIApplication.shared.key?.subviews.filter({$0.tag == 432 }).first?.removeFromSuperview()
        }
    }
    
    class func getLibraryHeaderTitles() -> [HeaderData] {
        var matchDates = [HeaderData]()
        matchDates.append(HeaderData(title: "MAGAZINES", isSelected: true))
        matchDates.append(HeaderData(title: "BOOKS", isSelected: false))
        return matchDates

    }
}
