//
//  AppCoordinator.swift
//  MLClone
//
//  Created by Decio Montanhani on 24/01/21.
//

import UIKit
import CommonsUI

final class AppCoordinator {

    let window: UIWindow
    let navigation = UINavigationController()

    init(window: UIWindow) {
        self.window = window
        setupStyle()
    }

    func setupStyle() {
        navigation.navigationBar.barTintColor = MLColor.primary
        navigation.navigationBar.tintColor = MLColor.Text.primary
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -1000, vertical: 0), for:UIBarMetrics.default)
    }

    func start() {
        SearchCoordinator(navigation: navigation).start()

        window.rootViewController = navigation
        window.backgroundColor = .white
        window.makeKeyAndVisible()
    }
}
