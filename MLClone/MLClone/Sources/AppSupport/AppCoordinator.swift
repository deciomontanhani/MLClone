//
//  AppCoordinator.swift
//  MLClone
//
//  Created by Decio Montanhani on 24/01/21.
//

import UIKit

final class AppCoordinator {

    let window: UIWindow
    let navigation = UINavigationController()

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        SearchCoordinator(navigation: navigation).start()

        window.rootViewController = navigation
        window.backgroundColor = .white
        window.makeKeyAndVisible()
    }
}
