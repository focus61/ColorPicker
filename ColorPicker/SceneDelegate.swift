//
//  SceneDelegate.swift
//  ColorPicker
//
//  Created by Aleksandr on 22.12.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let ws = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: ws.coordinateSpace.bounds)
        window?.windowScene = ws
        window?.rootViewController = MainTabBarController()
        window?.makeKeyAndVisible()
    }
}
