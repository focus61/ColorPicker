//
//  ColorPickerCollectionView.swift
//  ColorPicker
//
//  Created by Aleksandr on 22.12.2022.
//

import UIKit

final class ColorPickerTableView: UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        register(ColorPickerTableViewCell.self, forCellReuseIdentifier: ColorPickerTableViewCell.id)
        register(GradientColorTableViewCell.self, forCellReuseIdentifier: GradientColorTableViewCell.id)
        separatorInset = UIEdgeInsets.init(top: 0, left: .infinity, bottom: 0, right: 0)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
