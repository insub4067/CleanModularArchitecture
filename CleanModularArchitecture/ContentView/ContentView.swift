//
//  ContentView.swift
//  CleanModularArchitecture
//
//  Created by 김인섭 on 12/9/23.
//

import DataSource
import Domain
import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: ContentViewModel
    
    var body: some View {
        VStack(spacing: 12) {
            userInfoView()
            usernameTextField()
            getUserButton()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
        .overlay(alignment: .bottom) {
            if let error = viewModel.error {
                errorToastMessage(error)
            }
        }
    }
}

// MARK: - SubViews
extension ContentView {
    
    @ViewBuilder func userInfoView() -> some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: viewModel.fetchedUser?.avatarUrl ?? "")) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Circle()
                    .foregroundStyle(Color.gray.opacity(0.1))
            }
            .frame(width: 80, height: 80)
            .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(viewModel.fetchedUser?.name ?? "Placeholder")
                    .font(.title3.bold())
                    .foregroundStyle(Color.black.opacity(0.9))
                Text(viewModel.fetchedUser?.login ?? "Placeholder")
                    .font(.caption)
                    .foregroundStyle(Color.gray.opacity(0.7))
                Text(viewModel.fetchedUser?.bio ?? "Placeholder")
                    .font(.callout)
                    .foregroundStyle(Color.black.opacity(0.8))
            }
        }
    }
    
    @ViewBuilder func usernameTextField() -> some View {
        TextField("Type Github Username", text: $viewModel.searchText)
            .padding(.horizontal, 8)
            .padding(.vertical, 6)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
            .padding()
    }
    
    @ViewBuilder func getUserButton() -> some View {
        Button(action: {
            viewModel.getUser()
        }, label: {
            Text("Get User")
                .font(.subheadline.bold())
                .foregroundStyle(Color.white)
                .padding(12)
                .background(Color.blue)
                .cornerRadius(10)
        })
    }
    
    @ViewBuilder func errorToastMessage(_ error: Error) -> some View {
        Text(error.localizedDescription)
            .font(.title3.bold())
            .foregroundStyle(Color.black.opacity(0.6))
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .transition(.move(edge: .bottom))
            .onAppear {
                Task {
                    try await Task.sleep(nanoseconds: 3_000_000_000)
                    viewModel.error = .none
                }
            }
    }
}

#Preview {
    let repository = UserRepository()
    let usecase = GetUserUseCase(userRepository: repository)
    let viewModel = ContentViewModel(getUserUseCase: usecase)
    return ContentView(viewModel: viewModel)
}
