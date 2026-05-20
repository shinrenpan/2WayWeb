import UIKit

@MainActor
final class HomeHostController: UIViewController {
  private let viewModel: HomeViewModel
  private let viewOutlet = HomeViewOutlet()

  init(viewModel: HomeViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) { fatalError() }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setupWebView()
    viewModel.onRoute = { [weak self] router in
      self?.handleRouter(router)
    }
  }
}

// MARK: - Router

private extension HomeHostController {
  func handleRouter(_ router: HomeViewModel.Router) {
    switch router {
    case .askNamePermission:
      showPermissionAlert(message: "Please allow to access your name") { [weak self] in
        Task { await self?.viewModel.doAction(.view(.sendName)) }
      }
    case .askAgePermission:
      showPermissionAlert(message: "Please allow to access your age") { [weak self] in
        Task { await self?.viewModel.doAction(.view(.sendAge)) }
      }
    case let .sendNameToWeb(name):
      viewOutlet.sendName(name: name)
    case let .sendAgeToWeb(age):
      viewOutlet.sendAge(age: age)
    }
  }

  func showPermissionAlert(message: String, onConfirm: @escaping () -> Void) {
    let alert = UIAlertController(title: "Permission", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in onConfirm() })
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    present(alert, animated: true)
  }
}

// MARK: - Setup

private extension HomeHostController {
  func setupView() {
    view.addSubview(viewOutlet.mainView)
    NSLayoutConstraint.activate([
      viewOutlet.mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      viewOutlet.mainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      viewOutlet.mainView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      viewOutlet.mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
    ])
  }

  func setupWebView() {
    let userContentController = viewOutlet.webView.configuration.userContentController
    for jsFunction in HTMLHandler.JSFunction.allCases {
      userContentController.add(viewModel.htmlHandler, name: jsFunction.rawValue)
    }
    viewOutlet.reloadWebView()
  }
}
