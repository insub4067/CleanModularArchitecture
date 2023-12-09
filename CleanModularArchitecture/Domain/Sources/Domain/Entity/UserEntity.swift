//
//  File.swift
//  
//
//  Created by 김인섭 on 12/9/23.
//

import Foundation

public struct UserEntity {
    
    public let login: String
    public let avatarUrl: String
    public let name: String
    public let bio: String
    
    public init(
        login: String,
        avatarUrl: String,
        name: String,
        bio: String
    ) {
        self.login = login
        self.avatarUrl = avatarUrl
        self.name = name
        self.bio = bio
    }
}
