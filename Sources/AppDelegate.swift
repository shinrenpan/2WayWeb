//
//  AppDelegate.swift
//
//  Created by Joe Pan on 2024/10/11.
//

import UIKit

@main
final class AppDelegate: UIResponder {
    var window: UIWindow?
}

// MARK: - UIApplicationDelegate

extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let bounds = UIScreen.main.bounds
        let window = UIWindow(frame: bounds)
        window.backgroundColor = .white
        window.rootViewController = HomeVC()
        self.window = window
        window.makeKeyAndVisible()

        return true
    }
}
