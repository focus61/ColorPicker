//
//  GradientColorsViewController.swift
//  ColorPicker
//
//  Created by Aleksandr on 23.12.2022.
//

import UIKit

class GradientColorsViewController: UITabBarController {
    private let colorPickerTableView: ColorPickerTableView = .init(frame: .zero, style: .plain)
    private var gradientsArray: [GradientColor] = [
    ]


    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Gradient colors"
        navigationController?.navigationBar.prefersLargeTitles = true
        let backItem = UIBarButtonItem(title: nil, style: .plain, target: self, action: nil)
        backItem.tintColor = .black
        navigationItem.backBarButtonItem = backItem
        view.backgroundColor = UIColor(dynamicProvider: { trait in
            trait.userInterfaceStyle == .dark ? .black : .white
        })
        view.addSubview(colorPickerTableView)
        colorPickerTableView.translatesAutoresizingMaskIntoConstraints = false
        colorPickerTableView.delegate = self
        colorPickerTableView.dataSource = self
        NSLayoutConstraint.activate([
            colorPickerTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            colorPickerTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            colorPickerTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            colorPickerTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    private func modelToCGColors(model: [Color]) -> [CGColor] {
        return model.map { CustomColor(hex: $0.hex)?.cgColor ?? UIColor.white.cgColor }
    }
    private func modelToStrings(model: [Color]) -> [String] {
        return model.map { $0.description }
    }
}
extension GradientColorsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return gradientsArray.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GradientColorTableViewCell.id, for: indexPath)
        guard let gradientCell = cell as? GradientColorTableViewCell else { return cell }
        let currentGradient = gradientsArray[indexPath.row]
        let colorArray = modelToCGColors(model: currentGradient.selectedColors)
        let colorDescription = modelToStrings(model: currentGradient.selectedColors)
        gradientCell.gradientColorsCellFill(colorsForGradient: colorArray, colorsDescription: colorDescription)
        return gradientCell
    }
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return view.frame.height / 3.5
    }
}
