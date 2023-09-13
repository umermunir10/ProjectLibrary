//
//  Login.swift
//  Library App
//
//  Created by Hafiz Abdullah on 18/05/2022.
//

import Foundation

struct Login : Codable {
    
    var status : Bool?
    var message : String?
    var number : String?
    var code : String?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case message = "message"
        case number = "number"
        case code = "code"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        number = try values.decodeIfPresent(String.self, forKey: .number)
        code = try values.decodeIfPresent(String.self, forKey: .code)
    }
}
