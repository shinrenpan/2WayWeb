//
//  HomeVC.swift
//
//  Created by Joe Pan on 2024/10/11.
//

import Observation
import UIKit

final class HomeVC: UIViewController {
    private let vo = VO()
    private let vm = VM()
    private let router = Router()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSelf()
        setupBinding()
        setupVO()
    }
    
    // MARK: - Setup Something
    
    func setupSelf() {
        view.backgroundColor = vo.mainView.backgroundColor
        router.vc = self
    }
    
    func setupBinding() {
        _ = withObservationTracking {
            vm.state
        } onChange: { [weak self] in
            guard let self else { return }
            Task { @MainActor [weak self] in
                guard let self else { return }
                if viewIfLoaded?.window == nil { return }
                
                switch vm.state {
                case .none:
                    stateNone()
                case .askNamePermission:
                    stateAskNamepermission()
                case .askAgePermission:
                    stateAskAgepermission()
                case let .sendNameToWeb(name):
                    stateSendNameToWeb(name: name)
                case let .sendAgeToWeb(age):
                    stateSendAgeToWeb(age: age)
                }
                
                setupBinding()
            }
        }
    }
    
    func setupVO() {
        view.addSubview(vo.mainView)
        
        NSLayoutConstraint.activate([
            vo.mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            vo.mainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            vo.mainView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            vo.mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        let userContentController = vo.webView.configuration.userContentController
        
        for jsFunction in HTMLHandler.JSFunction.allCases {
            userContentController.add(vm.htmlHandler, name: jsFunction.rawValue)
        }
        
        vo.reloadWebView()
    }
    
    // MARK: - Handle State
    
    func stateNone() {}
    
    func stateAskNamepermission() {
        let alert = UIAlertController(title: "Permission", message: "Please allow to access your name", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            if let self {
                vm.doAction(.sendName)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func stateAskAgepermission() {
        let alert = UIAlertController(title: "Permission", message: "Please allow to access your age", preferredStyle: .alert)
        let okaction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            if let self {
                vm.doAction(.sendAge)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(okaction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func stateSendNameToWeb(name: String) {
        vo.webView.evaluateJavaScript("getUserName(\"\(name)\")")
    }
    
    func stateSendAgeToWeb(age: Int) {
        vo.webView.evaluateJavaScript("getUserAge(\(age))")
    }
}
