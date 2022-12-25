//
//  RandomColorsViewController.swift
//  ColorPicker
//
//  Created by Aleksandr on 22.12.2022.
//

import UIKit

final class RandomColorsViewController: UIViewController {
    private let colorPickerTableView: ColorPickerTableView = .init(frame: .zero, style: .plain)
    private let generateButton: UIButton = .init(frame: .zero)
    private var colorArray: [Color] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Random colors"
        navigationController?.navigationBar.prefersLargeTitles = false
        let backItem = UIBarButtonItem(title: nil, style: .plain, target: self, action: nil)
        backItem.tintColor = UIColor(dynamicProvider: { trait in
            trait.userInterfaceStyle == .dark ? .white : .black
        })
        navigationItem.backBarButtonItem = backItem
        view.backgroundColor = UIColor(dynamicProvider: { trait in
            trait.userInterfaceStyle == .dark ? .black : .white
        })
        view.addSubview(colorPickerTableView)
        colorPickerTableView.translatesAutoresizingMaskIntoConstraints = false
        colorPickerTableView.delegate = self
        colorPickerTableView.dataSource = self
        view.addSubview(generateButton)
        generateButton.translatesAutoresizingMaskIntoConstraints = false
        generateButton.setImage(UIImage(systemName: "arrow.triangle.2.circlepath"), for: .normal)
        generateButton.tintColor = .white
        generateButton.layer.cornerRadius = 25
        generateButton.backgroundColor = CustomColor.customBlueColor
        generateButton.addTarget(
            self,
            action: #selector(generateColors),
            for: .touchUpInside
        )
        generateButton.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        generateButton.layer.shadowRadius = 3
        generateButton.layer.shadowOpacity = 1
        generateButton.layer.shadowColor = CustomColor.customBlueColor.cgColor
        generateButton.layer.masksToBounds = false
        NSLayoutConstraint.activate([
            colorPickerTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            colorPickerTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            colorPickerTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            colorPickerTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            generateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            generateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            generateButton.widthAnchor.constraint(equalToConstant: 50),
            generateButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        newColors()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        generateButton.layer.shadowPath = UIBezierPath(
            roundedRect: CGRect(
                x: 0,
                y: 0,
                width: generateButton.frame.width,
                height: generateButton.frame.height + 2
            ),
            cornerRadius: generateButton.layer.cornerRadius
        ).cgPath
    }
    @objc private func generateColors() {
        newColors()
    }
    private func newColors() {
        var colors: [Color] = []
        for _ in 1...10 {
            let color = randomColor()
            let titleColor = color.0.accessibilityName
            let red = color.1
            let blue = color.2
            let green = color.3
            let hexToColor = hexStringFromColor(color: color.0)
            colors.append(
                Color(
                    hex: hexToColor,
                    description: titleColor,
                    red: Float(red),
                    green: Float(green),
                    blue: Float(blue)
                )
            )
        }
        colorArray = colors
        colorPickerTableView.reloadData()

    }
    ///Return randomColor, red, green, blue
    private func randomColor() -> (UIColor, CGFloat, CGFloat, CGFloat) {
        let red: CGFloat = .random(in: 0...1)
        let green: CGFloat = .random(in: 0...1)
        let blue: CGFloat = .random(in: 0...1)
        return (
            UIColor(
                red: red,
                green: green,
                blue: blue,
                alpha: 1
            ),
            red,
            green,
            blue
        )
    }
    private func hexStringFromColor(color: UIColor) -> String {
        let components = color.cgColor.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0
        let hexString = String.init(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
        return hexString
     }
}
extension RandomColorsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return colorArray.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ColorPickerTableViewCell.id, for: indexPath)
        guard let colorCell = cell as? ColorPickerTableViewCell else { return cell }
        let currentColor = colorArray[indexPath.row]
        colorCell.colorCellFill(
            hexDescription: currentColor.hex,
            colorDescription: currentColor.description,
//            groupDescription: currentColor.group,
            currentColor: hexToColor(currentColor.hex)
        )
        return colorCell
    }
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let currentColorData = colorArray[indexPath.row]
        let currentColor = hexToColor(currentColorData.hex)
        let detailViewController = ColorDetailViewController()
        detailViewController.selectedColorInfo(
            color: currentColor,
            title: currentColorData.description,
            hex: currentColorData.hex,
            red: currentColorData.red,
            green: currentColorData.green,
            blue: currentColorData.blue
        )
        detailViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    private func hexToColor(_ hex: String) -> UIColor {
        return CustomColor(hex: hex) ?? .white
    }
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return view.frame.height / 3.5
    }
}
// MARK: - UIContextMenuConfiguration -
extension RandomColorsViewController {
    func tableView(
        _ tableView: UITableView,
        contextMenuConfigurationForRowAt indexPath: IndexPath,
        point: CGPoint
    ) -> UIContextMenuConfiguration? {
        let item = colorArray[indexPath.row]
        let actionProvider: UIContextMenuActionProvider = { _ in
            let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { action in
                // Show system share sheet
            }
            
            // Create an action for renaming
            let copyHex = UIAction(title: "Copy hex", image: UIImage(systemName: "square.and.pencil")) { action in
                UIPasteboard.general.string = item.hex
            }
            
            // Here we specify the "destructive" attribute to show that it’s destructive in nature
            let addFavorite = UIAction(title: "Add to favorite", image: UIImage(systemName: "star.fill")) { action in
                // Perform delete
            }
            return UIMenu(title: "", children: [share, copyHex, addFavorite])
        }
        return UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil,
            actionProvider: actionProvider
        )
    }
    func tableView(
        _ tableView: UITableView,
        willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration,
        animator: UIContextMenuInteractionCommitAnimating
    ) {
        guard let destinationViewController = animator.previewViewController else {
            return
        }
        animator.addAnimations {
            self.show(destinationViewController, sender: self)
        }
    }
}

