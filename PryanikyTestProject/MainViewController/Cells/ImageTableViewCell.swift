//
//  ImageTableViewCell.swift
//  PryanikyTestProject
//
//  Created by Рыжков Артем on 28.09.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "ImageTableViewCell"
    
    lazy var imageLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupImageViewConstraints()
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
    
    func setupImageViewConstraints() {
        addSubview(cellImageView)
        cellImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        cellImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40).isActive = true
        cellImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        cellImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func setupImageLabelConstraints() {
        addSubview(imageLabel)
        imageLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 40).isActive = true
        imageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10).isActive = true
    }
}
