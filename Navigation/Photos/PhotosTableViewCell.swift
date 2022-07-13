//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by M M on 5/5/22.
//

import Foundation
import UIKit

protocol PhotosTableViewCellDelegate: AnyObject {
    func redirectToGalleryAction()
}

class PhotosTableViewCell: UITableViewCell {

    //==========================PROPERTIES=================================//
    /*
     1. private let photosLabel: UILabel
     2. private lazy var photosButton: UIButton
     3. private let firstImageView: UIImageView
     4. private let secondImageView: UIImageView
     5. private let thirdImageView: UIImageView
     6. private let fourthImageView: UIImageView
     7. private lazy var layout: UICollectionViewFlowLayout
     8. weak var delegate: PhotosTableViewCellDelegate?
     */
    private let photosLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        label.textColor = .black
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var photosButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.right"), for: UIControl.State.normal)
        button.tintColor = .black
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.addTarget(self, action: #selector(redirectToGalleryAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let firstImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let secondImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let thirdImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let fourthImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        return layout
    }()

    weak var delegate: PhotosTableViewCellDelegate?

    //===========================INITIALIZERS=================================//
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //===========================METHODS=================================//
    /*
     1. @objc func redirectToGalleryAction(_ sender: Any)
     2. private func addSubviews()
     3. private func setConstraints()
     4. func setup()
     */
    @objc func redirectToGalleryAction(_ sender: Any) {
        delegate?.redirectToGalleryAction()
    }

    private func addSubviews() {
        addSubview(photosLabel)
        addSubview(photosButton)
        addSubview(firstImageView)
        addSubview(secondImageView)
        addSubview(thirdImageView)
        addSubview(fourthImageView)
    }

    private func setConstraints() {
        let imageSize = (UIScreen.main.bounds.width - 48) / 4

        NSLayoutConstraint.activate([
            photosLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            photosLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            photosLabel.widthAnchor.constraint(equalToConstant: 150),
            photosLabel.bottomAnchor.constraint(equalTo: firstImageView.topAnchor, constant: -12),

            photosButton.centerYAnchor.constraint(equalTo: photosLabel.centerYAnchor),
            photosButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12),
            photosButton.widthAnchor.constraint(equalToConstant: 30),
            photosButton.bottomAnchor.constraint(equalTo: firstImageView.topAnchor, constant: -12),

            firstImageView.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: 12),
            firstImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            firstImageView.heightAnchor.constraint(equalToConstant: imageSize),
            firstImageView.widthAnchor.constraint(equalToConstant: imageSize),
            firstImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),

            secondImageView.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: 12),
            secondImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: imageSize + 20),
            secondImageView.heightAnchor.constraint(equalToConstant: imageSize),
            secondImageView.widthAnchor.constraint(equalToConstant: imageSize),
            secondImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),

            thirdImageView.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: 12),
            thirdImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: imageSize * 2 + 28),
            thirdImageView.heightAnchor.constraint(equalToConstant: imageSize),
            thirdImageView.widthAnchor.constraint(equalToConstant: imageSize),
            thirdImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),

            fourthImageView.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: 12),
            fourthImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: imageSize * 3 + 36),
            fourthImageView.heightAnchor.constraint(equalToConstant: imageSize),
            fourthImageView.widthAnchor.constraint(equalToConstant: imageSize),
            fourthImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12)
        ])
    }

    func setup() {
        self.firstImageView.image = UIImage(named: "1")
        self.secondImageView.image = UIImage(named: "2")
        self.thirdImageView.image = UIImage(named: "3")
        self.fourthImageView.image = UIImage(named: "4")
    }
    }
