//
//  MainTabBarController.swift
//  ColorPicker
//
//  Created by Aleksandr on 23.12.2022.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = CustomColor.customBlueColor
        setViewControllersForTabBar()
        setTitles()
    }
    private func setViewControllersForTabBar() {
        let randomNavigationCont = UINavigationController(rootViewController: RandomColorsViewController())
        let gradientNavigationCont = UINavigationController(rootViewController: GradientColorsViewController())
        setViewControllers([
            randomNavigationCont,
            gradientNavigationCont,
        ], animated: false)
    }

    private func setTitles() {
        viewControllers?.enumerated().forEach {
            switch $0 {
            case 0:
                $1.title = "Random"
                $1.tabBarItem.image = UIImage(systemName: "paintpalette")
            case 1:
                $1.title = "Gradient"
                $1.tabBarItem.image = UIImage(systemName: "square.3.layers.3d.down.backward")
            default: break
            }
        }
    }
}
