//
//  LineView.swift
//  ColorPicker
//
//  Created by Aleksandr on 24.12.2022.
//

import UIKit
enum LineType: String {
    case red, green, blue
}
final class LineView: UIView {
    private var lineType: LineType = .red
    private let lineTitle: UILabel = .init(frame: .zero)
    private let lineView: UIView = .init(frame: .zero)
    private let lineValue: UILabel = .init(frame: .zero)
    private let fillView: UIView = .init(frame: .zero)
    private var percentFill: Int = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(lineTitle)
        lineTitle.translatesAutoresizingMaskIntoConstraints = false
        lineTitle.textColor = .white
        
        addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.backgroundColor = .black
        lineView.clipsToBounds = true
        
        addSubview(lineValue)
        lineValue.translatesAutoresizingMaskIntoConstraints = false
        lineValue.textColor = .white
        lineValue.textAlignment = .left
        
        lineView.addSubview(fillView)
        fillView.backgroundColor = .white
        fillView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            lineTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            lineTitle.heightAnchor.constraint(equalToConstant: 20),
            lineTitle.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2),
            lineTitle.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            lineView.leadingAnchor.constraint(equalTo: lineTitle.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 20),
            lineView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            lineValue.heightAnchor.constraint(equalToConstant: 20),
            lineValue.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.1),
            lineValue.centerYAnchor.constraint(equalTo: centerYAnchor),
            lineValue.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            lineView.trailingAnchor.constraint(equalTo: lineValue.leadingAnchor, constant: -10)
        ])
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        lineView.layer.cornerRadius = lineView.frame.height / 4
        fillView.layer.cornerRadius = lineView.layer.cornerRadius
    }
    convenience init(type: LineType) {
        self.init(frame: .zero)
        self.lineType = type
        lineTitle.text = type.rawValue.capitalized
    }
    func lineFill(currentValue: Float) {
        lineValue.text = String(Int(currentValue * 255))
        let calculatedPercent: Float = 255 / 100
        percentFill = Int(currentValue * 255 / calculatedPercent)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func animateLineValue() {
        UIView.animate(withDuration: 0.5, delay: .zero, options: .curveEaseInOut) {
            self.fillView.frame = CGRect(
                x: self.lineView.bounds.origin.x,
                y: self.lineView.bounds.origin.y,
                width: self.lineView.frame.width / 100 * CGFloat(self.percentFill),
                height: 20
            )
        }
    }
}
