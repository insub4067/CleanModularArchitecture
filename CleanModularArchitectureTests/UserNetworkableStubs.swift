//
//  UserNetworkable.swift
//  CleanModularArchitectureTests
//
//  Created by 김인섭 on 12/16/23.
//

import Combine
import Foundation

@testable import Domain

// 항상 실패는 반환하는 Stub UserRepository
struct FailUserNetwork: UserRepositoriable {
    var getUser: (String) -> AnyPublisher<Domain.UserEntity, Error> = { _ in
        Fail(error: NSError(domain: "Fail", code: -1))
            .eraseToAnyPublisher()
    }
}

// 항상 Mock을 반환하는 Stub UserRepository
struct MockUserNetwork: UserRepositoriable {
    
    static let mock = UserEntity(
        login: "insub4067",
        avatarUrl: "https://avatars.githubusercontent.com/u/85481204?v=4",
        name: "insub",
        bio: "iOS Developer"
    )
    
    var getUser: (String) -> AnyPublisher<Domain.UserEntity, Error> = { _ in
        Just(mock)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
