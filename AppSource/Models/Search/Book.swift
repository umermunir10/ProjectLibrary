//
//  Book.swift
//  Library App
//
//  Created by Sixlogics on 26/06/2022.
//

import Foundation

enum BookType: String, Codable {
    case magazine = "magazine"
    case book = "book"
}

struct Book : Codable {
    
    let id : Int?
    let title : String?
    let slug : String?
    let pages : Int?
    let listingText : String?
    let type : BookType?
    let description : String?
    let price : Int?
    let rating : String?
    let epublink : String?
    let publisherName : String?
    let image : String?
    let url : String?
    var startDateString: String?
    var startDate: Date? {
        guard let startDateStr = startDateString else { return Date() }
        return Utilities.yyyyMMddHHmmss.date(from: startDateStr) ?? Date()
    }
    let isPublish : Int?
    let parentId : Int?
    let authorId : Int?
    let lang : String?
    var createdAtString: String?
    var createdAt: Date {
        guard let createdAtStr = createdAtString else { return Date() }
        return Utilities.yyyyMMddHHmmss.date(from: createdAtStr) ?? Date()
    }
    var updatedAtString: String?
    var updatedAtAt: Date {
        guard let updatedAtStr = updatedAtString else { return Date() }
        return Utilities.yyyyMMddHHmmss.date(from: updatedAtStr) ?? Date()
    }
    let autherName : String?
    let category : [Category]?
    var downloadedPath: String?
    var lastOpenedPageNo = 0
    var bookmarks: [Int] = []
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case title = "title"
        case slug = "slug"
        case pages = "pages"
        case listingText = "listing_text"
        case type = "type"
        case description = "description"
        case price = "price"
        case rating = "Rating"
        case epublink = "epublink"
        case publisherName = "publisher_name"
        case image = "image"
        case url = "url"
        case startDateString = "start_date"
        case isPublish = "is_publish"
        case parentId = "parent_id"
        case authorId = "author_id"
        case lang = "lang"
        case createdAtString = "created_at"
        case updatedAtString = "updated_at"
        case autherName = "auther_name"
        case category = "category"
        case downloadedPath = "downloadedPath"
        case lastOpenedPageNo = "lastOpenedPageNo"
        case bookmarks = "bookmarks"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        slug = try values.decodeIfPresent(String.self, forKey: .slug)
        pages = try values.decodeIfPresent(Int.self, forKey: .pages)
        listingText = try values.decodeIfPresent(String.self, forKey: .listingText)
        type = BookType(rawValue: (try (values.decodeIfPresent(String.self, forKey: .type) ?? "book")))
        description = try values.decodeIfPresent(String.self, forKey: .description)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        rating = try values.decodeIfPresent(String.self, forKey: .rating)
        epublink = try values.decodeIfPresent(String.self, forKey: .epublink)
        publisherName = try values.decodeIfPresent(String.self, forKey: .publisherName)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        startDateString = try values.decodeIfPresent(String.self, forKey: .startDateString)
        isPublish = try values.decodeIfPresent(Int.self, forKey: .isPublish)
        parentId = try values.decodeIfPresent(Int.self, forKey: .parentId)
        authorId = try values.decodeIfPresent(Int.self, forKey: .authorId)
        lang = try values.decodeIfPresent(String.self, forKey: .lang)
        createdAtString = try values.decodeIfPresent(String.self, forKey: .createdAtString)
        updatedAtString = try values.decodeIfPresent(String.self, forKey: .updatedAtString)
        autherName = try values.decodeIfPresent(String.self, forKey: .autherName)
        category = try values.decodeIfPresent([Category].self, forKey: .category)
        downloadedPath = try values.decodeIfPresent(String.self, forKey: .downloadedPath)
        lastOpenedPageNo = try values.decodeIfPresent(Int.self, forKey: .lastOpenedPageNo) ?? 0
        bookmarks = try values.decodeIfPresent([Int].self, forKey: .bookmarks) ?? []
    }
    
}
