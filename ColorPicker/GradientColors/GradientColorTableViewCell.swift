//
//  GradientColorTableViewCell.swift
//  ColorPicker
//
//  Created by Aleksandr on 23.12.2022.
//

import UIKit

final class GradientColorTableViewCell: ColorsTableViewCellWithShadow {
    static let id = "GradientColorTableViewCell"
    private let hexLabel: UILabel = .init(frame: .zero)
    private let colorDescriptionLabel: UILabel = .init(frame: .zero)
    private let gradientLayer = CAGradientLayer()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
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
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.cornerRadius = contentView.layer.cornerRadius
        contentView.layer.insertSublayer(gradientLayer, at: 0)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = contentView.bounds
        
    }
    func gradientColorsCellFill(
        colorsForGradient: [CGColor],
        colorsDescription: [String]
    ) {
        gradientLayer.colors = colorsForGradient
        contentView.layer.shadowColor = UIColor.lightGray.cgColor
        colorDescriptionLabel.text = colorsDescription.joined(separator: "\n")
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
