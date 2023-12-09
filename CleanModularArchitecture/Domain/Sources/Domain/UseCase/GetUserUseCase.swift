//
//  File.swift
//  
//
//  Created by 김인섭 on 12/9/23.
//

import Foundation
import Combine

public struct GetUserUseCase {
    
    private let userRepository: UserRepositoriable
    
    public init(userRepository: UserRepositoriable) {
        self.userRepository = userRepository
    }
    
    public func execute(username: String) -> AnyPublisher<UserEntity, Error>  {
        userRepository.getUser(username)
    }
}
