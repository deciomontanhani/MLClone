import Foundation

public enum NetworkError: Swift.Error {
    case `default`
    case wrongBaseUrl
    case notConnected
    case failedToDecode

    public var localizedDescription: String {
        switch self {
        case .default, .failedToDecode, .wrongBaseUrl:
            return "Ops! Estamos com problemas, tente novamente mais tarde."
        case .notConnected:
            return "Sem conexão com a internet :("
        }
    }
}
