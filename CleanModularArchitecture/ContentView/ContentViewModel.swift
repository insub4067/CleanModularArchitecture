//
//  ContentViewModel.swift
//  CleanModularArchitecture
//
//  Created by 김인섭 on 12/9/23.
//

import Combine
import Domain
import DataSource
import Foundation
import SwiftUI

final class ContentViewModel: ObservableObject {
    
    private let getUserUseCase: GetUserUseCase
    private var cancellable = Set<AnyCancellable>()
    
    init(getUserUseCase: GetUserUseCase) {
        self.getUserUseCase = getUserUseCase
    }
    
    @Published var fetchedUser: UserEntity?
    @Published var searchText = ""
    @Published var error: Error? = .none
    
    func getUser() {
        getUserUseCase.execute(username: searchText)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.error = error
                }
            } receiveValue: { [weak self] user in
                self?.fetchedUser = user
            }.store(in: &cancellable)

    }
}
