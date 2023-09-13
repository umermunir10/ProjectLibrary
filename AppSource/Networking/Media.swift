//
//  Media.swift
//  LibraryApp
//
//  Created by Faraz on 15/11/2021.
//

import Foundation

struct Media {
    
    let key: String
    let filename: String
    let data: Data
    let mimeType: String
    
    init(withFile file: Data, fileName: String, forKey key: String) {
        self.key = key
        self.mimeType = file.mimeType
        self.filename = fileName
        self.data = file
    }
}
