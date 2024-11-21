//
//  HomeVC+VM.swift
//
//  Created by Joe Pan on 2024/10/11.
//

import Observation
import UIKit

extension HomeVC {
    @Observable
    final class VM {
        private(set) var state = State.none
        @ObservationIgnored
        private let user = (name: "Joe", age: 45)
        @ObservationIgnored
        let htmlHandler = HTMLHandler()
        
        init() {
            setupSelf()
        }
        
        // MARK: - Public
        
        func doAction(_ action: Action) {
            switch action {
            case .sendName:
                state = .sendNameToWeb(user.name)
            case .sendAge:
                state = .sendAgeToWeb(user.age)
            }
        }
        
        // MARK: - Setup Someting
        
        func setupSelf() {
            htmlHandler.jsCallback = { [weak self] jsFunction in
                guard let self else { return }
                switch jsFunction {
                case .askNamePermission:
                    state = .askNamePermission
                case .askAgePermission:
                    state = .askAgePermission
                }
            }
        }
    }
}
