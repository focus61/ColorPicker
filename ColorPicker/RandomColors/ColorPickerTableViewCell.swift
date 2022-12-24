//
//  ColorPickerCollectionViewCell.swift
//  ColorPicker
//
//  Created by Aleksandr on 22.12.2022.
//

import UIKit

final class ColorPickerTableViewCell: ColorsTableViewCellWithShadow {
    static let id = "ColorPickerTableViewCell"
    private let hexLabel: UILabel = .init(frame: .zero)
    private let colorDescriptionLabel: UILabel = .init(frame: .zero)
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(hexLabel)
        hexLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        hexLabel.textColor = .white
        hexLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(colorDescriptionLabel)
        colorDescriptionLabel.textColor = .white
        colorDescriptionLabel.textAlignment = .right
        colorDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        colorDescriptionLabel.numberOfLines = 0
        colorDescriptionLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        NSLayoutConstraint.activate([
            hexLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            hexLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            hexLabel.trailingAnchor.constraint(equalTo: centerXAnchor),
            colorDescriptionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            colorDescriptionLabel.leadingAnchor.constraint(equalTo: centerXAnchor),
            colorDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    func colorCellFill(
        hexDescription: String,
        colorDescription: String,
        currentColor: UIColor
    ) {
        contentView.backgroundColor = currentColor
        hexLabel.text = hexDescription
        colorDescriptionLabel.text = colorDescription.split(separator: " ").joined(separator: "\n")
        contentView.layer.shadowColor = currentColor.cgColor
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
