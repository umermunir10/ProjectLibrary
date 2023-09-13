//
//  BookFilter.swift
//  Library App
//
//  Created by Sixlogics on 26/06/2022.
//

import Foundation

struct BookFilter {
    
    var filter: String
    var imageName: String
    
    init(filter: String, imageName: String) {
        self.filter = filter
        self.imageName = imageName
    }
    
    static func getFilters() -> [BookFilter] {
        var filters: [BookFilter] = []
        filters.append(BookFilter(filter: "Magazines", imageName: "pdf DOC ICON"))
        filters.append(BookFilter(filter: "Books", imageName: "READING DARK"))
        filters.append(BookFilter(filter: "Want to read", imageName: "ARROW NEXT ICON COLLECTION"))
        filters.append(BookFilter(filter: "Downloaded", imageName: "DOWNLOAD-1"))
        filters.append(BookFilter(filter: "Finished", imageName: "FINISHED ICON"))
        return filters
    }
}
