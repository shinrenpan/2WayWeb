//
//  HomeVC+VO.swift
//
//  Created by Joe Pan on 2024/10/11.
//

import UIKit
import WebKit

extension HomeVC {
    @MainActor
    final class VO {
        let mainView = UIView(frame: .zero)
        let webView = WKWebView(frame: .zero)
        
        init() {
            setupSelf()
            addViews()
        }
        
        // MARK: - Public
        
        func reloadWebView() {
            let url = Bundle.main.url(forResource: "index", withExtension: "html")!
            webView.loadFileURL(url, allowingReadAccessTo: url)
        }
        
        // MARK: - Private
        
        private func setupSelf() {
            mainView.translatesAutoresizingMaskIntoConstraints = false
            webView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        private func addViews() {
            mainView.addSubview(webView)
            NSLayoutConstraint.activate([
                webView.topAnchor.constraint(equalTo: mainView.topAnchor),
                webView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
                webView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
                webView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            ])
        }
    }
}
