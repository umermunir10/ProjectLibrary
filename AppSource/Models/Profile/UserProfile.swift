//
//  UserProfile.swift
//  Library App
//
//  Created by Sixlogics on 26/06/2022.
//

import Foundation

struct UserProfile : Codable {
    
    let id : Int?
    let name : String?
    let image : String?
    let phone : String?
    let email : String?
    let isVerified : Int?
    let createdAt : String?
    let updatedAt : String?
    var subscribedBooks: [Int] = []
    var readingGoal : Int = 5
    var subscription: Subscription? {
        didSet {
            save()
        }
    }
    
    var readingTimeInSeconds : Int = 0 {
        didSet {
            save()
        }
    }
    
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
        case image = "image"
        case phone = "phone"
        case email = "email"
        case isVerified = "is_verified"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case subscribedBooks = "subscribedBooks"
        case readingGoal = "readingGoal"
        case readingTimeInSeconds = "readingTimeInSeconds"
        case subscription = "user subscription"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        isVerified = try values.decodeIfPresent(Int.self, forKey: .isVerified)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        subscribedBooks = try values.decodeIfPresent([Int].self, forKey: .subscribedBooks) ?? []
        readingGoal = try values.decodeIfPresent(Int.self, forKey: .readingGoal) ?? 5
        readingTimeInSeconds = try values.decodeIfPresent(Int.self, forKey: .readingTimeInSeconds) ?? 0
        subscription = try values.decodeIfPresent(Subscription.self, forKey: .subscription)
    }
    
    private func save() {
        CacheManager.shared.userProfile = self
    }
    
}
