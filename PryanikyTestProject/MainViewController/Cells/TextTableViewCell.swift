//
//  TextTableViewCell.swift
//  PryanikyTestProject
//
//  Created by Рыжков Артем on 28.09.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

class TextTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "TextTableViewCell"
    
    lazy var imageLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupImageLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupImageLabelConstraints() {
        addSubview(imageLabel)
        imageLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40).isActive = true
        imageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10).isActive = true
    }

}
