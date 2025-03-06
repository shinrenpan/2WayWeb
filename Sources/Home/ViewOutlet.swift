//
//  ViewOutlet.swift
//
//  Created by Joe Pan on 2024/10/11.
//

import UIKit
import WebKit

@MainActor final class ViewOutlet {
    let mainView = UIView(frame: .zero)
    let webView = WKWebView(frame: .zero)
    
    init() {
        setupSelf()
        addViews()
    }
}

// MARK: - Internal

extension ViewOutlet {
    func reloadWebView() {
        let url = Bundle.main.url(forResource: "index", withExtension: "html")!
        webView.loadFileURL(url, allowingReadAccessTo: url)
    }
    
    func sendName(name: String) {
        webView.evaluateJavaScript("getUserName(\"\(name)\")")
    }
    
    func sendAge(age: Int) {
        webView.evaluateJavaScript("getUserAge(\(age))")
    }
}

// MARK: - Private

private extension ViewOutlet {
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
