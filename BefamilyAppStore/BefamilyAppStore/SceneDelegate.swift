//
//  SceneDelegate.swift
//  BefamilyAppStore
//
//  Created by juntaek.oh on 2022/08/06.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        self.window = UIWindow(windowScene: windowScene)
        let mainViewController = ViewController()
        let naviController = UINavigationController(rootViewController: mainViewController)

        self.window?.rootViewController = naviController
        self.window?.makeKeyAndVisible()
    }
}

