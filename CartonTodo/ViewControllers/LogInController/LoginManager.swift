//
//  LoginManager.swift
//  CartonTodo
//
//  Created by ohhyung kwon on 28/7/2022.
//

import Foundation

class LoginManager{
    static let shared = LoginManager()

    var isLogin: Bool = false {
        didSet{
            NotificationCenter.default.post(name: .loginChanged, object: isLogin)
        }
    }
}

extension Notification.Name{
    static let loginChanged = Notification.Name("LoginStatusHasChanged")
}
