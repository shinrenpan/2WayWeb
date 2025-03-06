//
//  Router.swift
//
//  Created by Joe Pan on 2024/10/11.
//

import UIKit

@MainActor final class Router {
    weak var vc: ViewController?
}

// MARK: - Internal

extension Router {
    func showAskNamePermission(callback: @escaping ((UIAlertAction) -> Void)) {
        let alert = UIAlertController(title: "Permission", message: "Please allow to access your name", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: callback)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        vc?.present(alert, animated: true)
    }
    
    func showAskAgePermission(callback: @escaping ((UIAlertAction) -> Void)) {
        let alert = UIAlertController(title: "Permission", message: "Please allow to access your age", preferredStyle: .alert)
        let okaction = UIAlertAction(title: "OK", style: .default, handler: callback)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(okaction)
        alert.addAction(cancelAction)
        vc?.present(alert, animated: true)
    }
}
