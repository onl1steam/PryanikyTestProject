//
//  ImageTableViewCell.swift
//  PryanikyTestProject
//
//  Created by Рыжков Артем on 28.09.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

final class ImageTableViewCell: UITableViewCell {
    
    // MARK: - Public Properties
    static let reuseIdentifier = "ImageTableViewCell"
    
    // MARK: - Private Properties
    private lazy var imageLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupImageViewConstraints()
        setupImageLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UITableViewCell
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Public methods
    func setCellImage(_ image: UIImage) {
        cellImageView.image = image
    }
    
    func setCellTitle(_ title: String) {
        imageLabel.text = title
    }
    
    // MARK: - Private Methods
    private func setupImageViewConstraints() {
        addSubview(cellImageView)
        NSLayoutConstraint.activate([
            cellImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            cellImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            cellImageView.heightAnchor.constraint(equalToConstant: 100),
            cellImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupImageLabelConstraints() {
        addSubview(imageLabel)
        NSLayoutConstraint.activate([
            imageLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 40),
            imageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10)
        ])
    }
}
