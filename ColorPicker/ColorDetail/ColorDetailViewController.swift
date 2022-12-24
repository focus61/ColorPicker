//
//  ColorDetailViewController.swift
//  ColorPicker
//
//  Created by Aleksandr on 22.12.2022.
//

import UIKit

final class ColorDetailViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func selectedColorInfo(color: UIColor, title: String) {
        view.backgroundColor = color
        self.title = title
    }
}
