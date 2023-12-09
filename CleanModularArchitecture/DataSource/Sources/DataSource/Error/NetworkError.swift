//
//  File.swift
//  
//
//  Created by 김인섭 on 12/9/23.
//

import Foundation

public enum NetworkError: Error {
    case unknownError
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unknownError:
            return NSLocalizedString("네트워크에 문제가 생겼습니다.", comment: "Unknown Error")
        }
    }
}
