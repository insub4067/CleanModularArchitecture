//
//  UserRepository.swift
//
//
//  Created by 김인섭 on 12/9/23.
//

import Combine
import Domain
import Foundation

public struct UserRepository: UserRepositoriable {
    
    public init() { }
    
    public var getUser: (String) -> AnyPublisher<Domain.UserEntity, Error> = { username in
        let url = URL(string: "https://api.github.com" + "/users" + "/\(username)")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: UserDTO.self, decoder: JSONDecoder())
            .map {
                .init(
                    login: $0.login,
                    avatarUrl: $0.avatar_url,
                    name: $0.name,
                    bio: $0.bio
                )
            }.eraseToAnyPublisher()
    }
}
