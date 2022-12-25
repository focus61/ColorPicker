//
//  DetailView.swift
//  ColorPicker
//
//  Created by Aleksandr on 24.12.2022.
//

import UIKit

final class DetailView: UIView {
    private let rgbView: RGBView = .init(frame: .zero)
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(rgbView)
        rgbView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rgbView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            rgbView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            rgbView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            rgbView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3)
        ])
    }
    func detailValue(
        red: Float,
        green: Float,
        blue: Float
    ) {
        rgbView.rgbFill(
            red: red,
            green: green,
            blue: blue
        )
    }
    func detailInfo(
        color: UIColor,
        title: String
    ) {
        backgroundColor = color
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
