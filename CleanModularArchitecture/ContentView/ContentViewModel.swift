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

final class ContentViewModel: ObservableObject {
    
    private let getUserUseCase: GetUserUseCase
    private var cancellable = Set<AnyCancellable>()
    
    init(getUserUseCase: GetUserUseCase) {
        self.getUserUseCase = getUserUseCase
    }
    
    @Published var user: UserEntity?
    @Published var text = ""
    
    func getUser() {
        getUserUseCase.execute(username: text)
            .receive(on: RunLoop.main)
            .sink { _ in
                
            } receiveValue: { [weak self] user in
                self?.user = user
            }.store(in: &cancellable)

    }
}
