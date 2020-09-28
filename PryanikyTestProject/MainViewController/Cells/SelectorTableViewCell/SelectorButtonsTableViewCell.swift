//
//  SelectorButtonsTableViewCell.swift
//  PryanikyTestProject
//
//  Created by Рыжков Артем on 28.09.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

class SelectorButtonsTableViewCell: UITableViewCell {
    
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
        imageView.image = UIImage(systemName: "circle")
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
    
    func setupSelectorImageViewConstraints() {
        addSubview(selectorImageView)
        selectorImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        selectorImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        selectorImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        selectorImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func setupSelectorLabelConstraints() {
        addSubview(selectorLabel)
        selectorLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        selectorLabel.leadingAnchor.constraint(equalTo: selectorImageView.trailingAnchor, constant: 20).isActive = true
        selectorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10).isActive = true
    }

}
