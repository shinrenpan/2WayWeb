import UIKit
import WebKit

@MainActor
final class HomeViewOutlet {
  let mainView = UIView(frame: .zero)
  let webView = WKWebView(frame: .zero)

  init() {
    setupSelf()
    addViews()
  }
}

extension HomeViewOutlet {
  func reloadWebView() {
    let url = Bundle.main.url(forResource: "index", withExtension: "html")!
    webView.loadFileURL(url, allowingReadAccessTo: url)
  }

  func sendName(name: String) {
    webView.callAsyncJavaScript("getUserName(name)", arguments: ["name": name], in: nil, in: .page, completionHandler: nil)
  }

  func sendAge(age: Int) {
    webView.callAsyncJavaScript("getUserAge(age)", arguments: ["age": age], in: nil, in: .page, completionHandler: nil)
  }
}

private extension HomeViewOutlet {
  func setupSelf() {
    mainView.translatesAutoresizingMaskIntoConstraints = false
    webView.translatesAutoresizingMaskIntoConstraints = false
  }

  func addViews() {
    mainView.addSubview(webView)
    NSLayoutConstraint.activate([
      webView.topAnchor.constraint(equalTo: mainView.topAnchor),
      webView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
      webView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
      webView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
    ])
  }
}
