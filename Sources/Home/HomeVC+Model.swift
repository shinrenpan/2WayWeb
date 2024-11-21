//
//  HomeVC+Model.swift
//
//  Created by Joe Pan on 2024/10/11.
//

import UIKit

extension HomeVC {
    
    // MARK: - Action / Request
    
    enum Action {
        case sendName
        case sendAge
    }
    
    // MARK: - State / Response
    
    enum State {
        case none
        case askNamePermission
        case askAgePermission
        case sendNameToWeb(String)
        case sendAgeToWeb(Int)
    }
    
    // MARK: - Models
    
    struct User {
        let name: String
        let age: Int
    }
}
