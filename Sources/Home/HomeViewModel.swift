import Observation

@Observable
@MainActor
final class HomeViewModel {
  enum Action: Sendable {
    case view(ViewAction)
    case js(JSAction)
  }

  var state: State = .init()

  @ObservationIgnored
  var onRoute: (@MainActor (Router) -> Void)?

  @ObservationIgnored
  let htmlHandler = HTMLHandler()

  @ObservationIgnored
  private let user = User(name: "Joe", age: 45)

  init() {
    setupHTMLHandler()
  }

  func doAction(_ action: Action) async {
    switch action {
    case let .view(action):
      await handleViewAction(action)
    case let .js(action):
      await handleJSAction(action)
    }
  }
}

// MARK: - View Action

extension HomeViewModel {
  enum ViewAction: Sendable {
    case sendName
    case sendAge
  }

  private func handleViewAction(_ action: ViewAction) async {
    switch action {
    case .sendName:
      onRoute?(.sendNameToWeb(name: user.name))
    case .sendAge:
      onRoute?(.sendAgeToWeb(age: user.age))
    }
  }
}

// MARK: - JS Action

extension HomeViewModel {
  enum JSAction: Sendable {
    case askNamePermission
    case askAgePermission
  }

  private func handleJSAction(_ action: JSAction) async {
    switch action {
    case .askNamePermission:
      onRoute?(.askNamePermission)
    case .askAgePermission:
      onRoute?(.askAgePermission)
    }
  }
}

// MARK: - Router

extension HomeViewModel {
  enum Router: Sendable {
    case askNamePermission
    case askAgePermission
    case sendNameToWeb(name: String)
    case sendAgeToWeb(age: Int)
  }
}

// MARK: - Private

private extension HomeViewModel {
  func setupHTMLHandler() {
    htmlHandler.jsCallback = { [weak self] jsFunction in
      guard let self else { return }
      switch jsFunction {
      case .askNamePermission:
        Task { await self.doAction(.js(.askNamePermission)) }
      case .askAgePermission:
        Task { await self.doAction(.js(.askAgePermission)) }
      }
    }
  }
}
