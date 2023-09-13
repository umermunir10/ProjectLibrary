//
//  VerificationRsponse.swift
//  Library App
//
//  Created by Sixlogics on 26/06/2022.
//

import Foundation
import CloudKit

struct VerificationRsponse : Codable {
    var status : Bool?
    var message : String?
    var userProfile: UserProfile?
    let subscribedBooks: [SubscribedBook]?
    let subscriptions: [Subscription]?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case message = "message"
        case userProfile = "profile"
        case subscribedBooks = "subscribed books"
        case subscriptions = "user subscription"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        userProfile = try values.decodeIfPresent(UserProfile.self, forKey: .userProfile)
        subscribedBooks = try values.decodeIfPresent([SubscribedBook].self, forKey: .subscribedBooks)
        subscriptions = try values.decodeIfPresent([Subscription].self, forKey: .subscriptions)
        if let subscriptions = subscriptions, let subscription = subscriptions.first {
            userProfile?.subscription = subscription
        }
    }
}
