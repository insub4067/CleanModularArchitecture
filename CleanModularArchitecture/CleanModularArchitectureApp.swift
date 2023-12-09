//
//  CleanModularArchitectureApp.swift
//  CleanModularArchitecture
//
//  Created by 김인섭 on 12/9/23.
//

import DataSource
import Domain
import SwiftUI

@main
struct CleanModularArchitectureApp: App {
    
    var contentViewModel: ContentViewModel {
        let repository = UserRepository()
        let usecase = GetUserUseCase(userRepository: repository)
        return .init(getUserUseCase: usecase)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: contentViewModel)
        }
    }
}
