//
//  lll.swift
//  Library App
//
//  Created by Sixlogics on 26/06/2022.
//

import Foundation

class CacheManager {
    
    // MARK: - Properties
    static let shared = CacheManager()
    private var _userProfile: UserProfile?
    
    var userProfile: UserProfile? {
        get {
            load()
            return _userProfile
        }
        set {
            _userProfile = newValue
            save()
        }
    }
    
    // MARK: -
    // Initialization
    private init() {
    }
    
    private func load() {
        do {
            if let decoded  = UserDefaults.standard.data(forKey: CacheKeys.profile) {
                let encodeData = try JSONDecoder().decode(UserProfile.self, from: decoded)
                CacheManager.shared._userProfile = encodeData
            }
        } catch {
            print(error)
        }
    }
    
    private func save() {
        do {
            let encodeData = try JSONEncoder().encode(_userProfile)
            UserDefaults.standard.set(encodeData, forKey: CacheKeys.profile)
            // synchronize is not needed
        } catch { print(error) }
    }
}
