//
//  ViewController.swift
//
//  Created by Joe Pan on 2024/10/11.
//

import Observation
import UIKit

final class ViewController: UIViewController {
    private let vo = ViewOutlet()
    private let vm = ViewModel()
    private let router = Router()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSelf()
        setupBinding()
        setupVO()
    }
}

// MARK: - Private

private extension ViewController {
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
                    stateAskNamePermission()
                case .askAgePermission:
                    stateAskAgePermission()
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
    
    func stateNone() {}
    
    func stateAskNamePermission() {
        router.showAskNamePermission { [weak self] _ in
            self?.vm.doAction(.sendName)
        }
    }
    
    func stateAskAgePermission() {
        router.showAskAgePermission { [weak self] _ in
            self?.vm.doAction(.sendAge)
        }
    }
    
    func stateSendNameToWeb(name: String) {
        vo.sendName(name: name)
    }
    
    func stateSendAgeToWeb(age: Int) {
        vo.sendAge(age: age)
    }
}
