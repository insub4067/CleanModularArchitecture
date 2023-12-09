//
//  CleanModularArchitectureTests.swift
//  CleanModularArchitectureTests
//
//  Created by 김인섭 on 12/9/23.
//

import Combine
import XCTest

@testable import CleanModularArchitecture
@testable import DataSource
@testable import Domain


final class ContentViewModelTests: XCTestCase {

    
    func test_네트워크가실패한경우() {
        
        // Given
        var repository = UserRepository()
        repository.getUser = { _ in
            Fail(error: NetworkError.unknownError)
                .eraseToAnyPublisher()
        }
        let usecase = GetUserUseCase(userRepository: repository)
        let sut = ContentViewModel(getUserUseCase: usecase)
        
        // When
        sut.getUser()
        
        // Then
        let expectation = expectation(description: "1초 후 테스트 실행")
        let result = XCTWaiter.wait(for: [expectation], timeout: 1.0)
        guard result == XCTWaiter.Result.timedOut else {
            return XCTFail("테스트 실패")
        }
        XCTAssertNotNil(sut.error)
    }
    
    func test_네트워크가성공한경우() {
        
        // Given
        let mock = UserEntity(
            login: "insub4067",
            avatarUrl: "https://avatars.githubusercontent.com/u/85481204?v=4",
            name: "insub",
            bio: "iOS Developer"
        )
        var repository = UserRepository()
        repository.getUser = { _ in
            Just(mock)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        let usecase = GetUserUseCase(userRepository: repository)
        let sut = ContentViewModel(getUserUseCase: usecase)
        
        // When
        sut.getUser()
        
        // Then
        let expectation = expectation(description: "1초 후 테스트 실행")
        let result = XCTWaiter.wait(for: [expectation], timeout: 1.0)
        guard result == XCTWaiter.Result.timedOut else {
            return XCTFail("테스트 실패")
        }
        XCTAssertEqual(sut.user?.login, mock.login)
    }
}
