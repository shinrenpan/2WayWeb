//
//  Model.swift
//
//  Created by Joe Pan on 2024/10/11.
//

enum Action {
    case sendName
    case sendAge
}

enum State {
    case none
    case askNamePermission
    case askAgePermission
    case sendNameToWeb(String)
    case sendAgeToWeb(Int)
}

struct User {
    let name: String
    let age: Int
}
