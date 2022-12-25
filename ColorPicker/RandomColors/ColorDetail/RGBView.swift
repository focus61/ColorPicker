//
//  RGBView.swift
//  ColorPicker
//
//  Created by Aleksandr on 24.12.2022.
//

import UIKit

final class RGBView: UIStackView {
    private let redView: LineView = .init(type: .red)
    private let greenView: LineView = .init(type: .green)
    private let blueView: LineView = .init(type: .blue)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .vertical
        distribution = .fillEqually
        alignment = .center
        backgroundColor = UIColor(white: 0, alpha: 0.6)
        layer.opacity = 1
        clipsToBounds = true
        layer.cornerRadius = 25
        addLineView(redView)
        addLineView(greenView)
        addLineView(blueView)
    }
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addLineView(_ line: UIView) {
        addArrangedSubview(line)
        line.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            line.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            line.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
    }
    func rgbFill(
        red: Float,
        green: Float,
        blue: Float
    ) {
        redView.lineFill(currentValue: red)
        greenView.lineFill(currentValue: green)
        blueView.lineFill(currentValue: blue)
        redView.animateLineValue()
        greenView.animateLineValue()
        blueView.animateLineValue()
    }
}
