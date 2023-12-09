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
    
    private let baseurl = "https://api.github.com"
    
    public func getUser(username: String) -> AnyPublisher<UserEntity, Error> {
        let url = URL(string: baseurl + "/users" + "/\(username)")!
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
