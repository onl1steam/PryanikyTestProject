//
//  SelectorButtonsTableViewCell.swift
//  PryanikyTestProject
//
//  Created by Рыжков Артем on 28.09.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

final class SelectorButtonsTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "SelectorButtonsTableViewCell"
    
    lazy var selectorLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var selectorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSelectorImageViewConstraints()
        setupSelectorLabelConstraints()
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
    
    private func setupSelectorImageViewConstraints() {
        addSubview(selectorImageView)
        NSLayoutConstraint.activate([
            selectorImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            selectorImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            selectorImageView.heightAnchor.constraint(equalToConstant: 20),
            selectorImageView.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func setupSelectorLabelConstraints() {
        addSubview(selectorLabel)
        NSLayoutConstraint.activate([
            selectorLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            selectorLabel.leadingAnchor.constraint(equalTo: selectorImageView.trailingAnchor, constant: 20),
            selectorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10)
        ])
    }
}
