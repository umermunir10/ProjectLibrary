//
//  String.swift
//  projectLibrary
//
//  Created by Umer Munir on 08/08/2023.
//

import Foundation

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    public func isAllDigits()->Bool {
        let charcterSet  = NSCharacterSet(charactersIn: "+0123456789{2}").inverted
        let inputString = self.components(separatedBy: charcterSet)
        let filtered = inputString.joined(separator: "")
        return  self == filtered
    }
    
    func isValidPhoneNumber() -> Bool
    {
        let regExp = "^[0-9]{10}$"
        
        if let range = self.range(of:regExp, options: .regularExpression) {
            let result = self[range]
            return result == self
        }
        return false
    }
}
