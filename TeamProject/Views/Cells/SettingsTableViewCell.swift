//
//  SettingsTableViewCell.swift
//  TeamProject
//
//  Created by Jung Hyun Kim on 2023/06/12.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    static let identifier = "SettingsTableViewCell"
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(iconImageView)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let padding: CGFloat = 20
        let size: CGFloat = contentView.frame.size.height
        let imageSize: CGFloat = size/1.5
        iconImageView.frame = CGRect(x: padding, y: (size-imageSize)/2, width: imageSize, height: imageSize)
        label.frame = CGRect(x: 30 + iconImageView.frame.size.width, y: 0, width: contentView.frame.size.width - 20 - iconImageView.frame.size.width, height: contentView.frame.size.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
    }

    public func configure(with model: SettingsOptions) {
        label.text = model.title
        iconImageView.image = model.icon
    }
}
