//
//  Category.swift
//  Library App
//
//  Created by Sixlogics on 26/06/2022.
//

import Foundation

struct Category : Codable {
    
    let id : Int?
    let name : String?
    let slug : String?
    let description : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
        case slug = "slug"
        case description = "description"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        slug = try values.decodeIfPresent(String.self, forKey: .slug)
        description = try values.decodeIfPresent(String.self, forKey: .description)
    }
    
}
