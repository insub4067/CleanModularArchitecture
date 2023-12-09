//
//  UserRepositoriable.swift
//
//
//  Created by 김인섭 on 12/9/23.
//

import Combine

public protocol UserRepositoriable {
    
    var getUser: (String) -> AnyPublisher<UserEntity, Error> { get set }
}
