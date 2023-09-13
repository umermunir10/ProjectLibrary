//
//  dasda.swift
//  Library App
//
//  Created by Sixlogics on 26/06/2022.
//

import Foundation

struct SubscribedBook: Codable {
    
    let bookId: Int?
    
    enum CodingKeys: String, CodingKey {
        case bookId = "book_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.bookId = try values.decodeIfPresent(Int.self, forKey: .bookId)
    }
}

struct Subscription: Codable {
    
    let id: Int?
    let userId: Int?
    let subscriptionName: String?
    let subscriptionType: String?
    let startDateString: String?
    let endDateString: String?
    var status: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case userId = "user_id"
        case subscriptionName = "subscription_name"
        case subscriptionType = "subscription_type"
        case startDateString = "start_date"
        case endDateString = "end_date"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decodeIfPresent(Int.self, forKey: .id)
        self.userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        self.subscriptionName = try values.decodeIfPresent(String.self, forKey: .subscriptionName)
        self.subscriptionType = try values.decodeIfPresent(String.self, forKey: .subscriptionType)
        self.startDateString = try values.decodeIfPresent(String.self, forKey: .startDateString)
        self.endDateString = try values.decodeIfPresent(String.self, forKey: .endDateString)
        self.status = try values.decodeIfPresent(Bool.self, forKey: .status) ?? false
    }
    
    init(userId: Int, subscriptionName: String, subscriptionType: String, startDateString: String, endDateString: String) {
        self.id = 0
        self.userId = userId
        self.subscriptionName = subscriptionName
        self.subscriptionType = subscriptionType
        self.startDateString = startDateString
        self.endDateString = endDateString
    }
}
