//
//  URLs.swift
//  LibraryApp
//
//  Created by Faraz on 12/11/2021.
//

import Foundation

var kBaseURL: String {
    get {
        switch currentEnvironment {
        case .dev:
            return "https://staginglibrary.6lgx.com/api"
        case .staging:
            return ""
        case .qa:
            return ""
        case .live:
            return ""
        }
    }
}
