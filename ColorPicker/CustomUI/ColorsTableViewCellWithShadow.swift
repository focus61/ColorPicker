//
//  ColorsTableViewCellWithShadow.swift
//  ColorPicker
//
//  Created by Aleksandr on 23.12.2022.
//

import UIKit

class ColorsTableViewCellWithShadow: UITableViewCell {
    fileprivate func contentViewConfig() {
        contentView.layer.cornerRadius = 20
        contentView.layer.shadowOffset = CGSize(width: 0, height: 3)
        contentView.layer.shadowRadius = 3
        contentView.layer.shadowOpacity = 1
        contentView.layer.masksToBounds = false
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = CGRect(
            x: 20,
            y: 10,
            width: frame.width - 40,
            height: frame.height - 20
        )
        contentView.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height), cornerRadius: contentView.layer.cornerRadius).cgPath
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentViewConfig()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
