//
//  UserRepositoriable.swift
//
//
//  Created by 김인섭 on 12/9/23.
//

import Combine

public protocol UserRepositoriable {
    
    func getUser(username: String) -> AnyPublisher<UserEntity, Error>
}
