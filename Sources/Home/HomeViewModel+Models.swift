import Foundation

// MARK: - State

extension HomeViewModel {
  struct State: Sendable {
    var viewStatus: ViewStatus = .idle
  }

  enum ViewStatus: Sendable {
    case idle
    case askNamePermission
    case askAgePermission
    case sendNameToWeb(name: String)
    case sendAgeToWeb(age: Int)
  }
}

// MARK: - Domain Models

extension HomeViewModel {
  struct User: Sendable {
    let name: String
    let age: Int
  }
}
