/*
 Program name: Navigation
 File name: PostTableViewCell.swift

 Created by M M on 4/29/22.
 */

import Foundation
import UIKit
import StorageService
import iOSIntPackage

class PostTableViewCell: UITableViewCell {


    //==========================PROPERTIES=================================//
    /*
     1. private let authorLabel: UILabel
     2. private let postImageView: UIImageView
     3. private let descriptionLabel: UILabel
     4. private let likesLabel: UILabel
     5. private let viewsLabel: UILabel
     */
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let likesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let viewsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


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
    /*1. func set(post: Post)
      2. private func addSubviews()
      3. private func setConstraints()
     */
    func set(post: Post) {
        self.authorLabel.text = post.author
        self.postImageView.image = UIImage(named: post.image)
        self.descriptionLabel.text = post.description
        self.likesLabel.text = "Likes: \(post.likes)"
        self.viewsLabel.text = "Views: \(post.views)"

        let random = Int.random(in: 1...4)
        let filter: ColorFilter?

        switch random {
        case 1: filter = .fade
        case 2: filter = .colorInvert
        case 3: filter = .noir
        case 4: filter = .chrome
        default: filter = nil
        }

        let imageProcessor = ImageProcessor()
        guard let filter = filter else { return }
        guard let image = postImageView.image else { return }
        
        imageProcessor.processImage(sourceImage: image, filter: filter, completion: { filteredImage in
            postImageView.image = filteredImage
        })
    }

    private func addSubviews() {
        self.contentView.addSubview(authorLabel)
        self.contentView.addSubview(postImageView)
        self.contentView.addSubview(descriptionLabel)
        self.contentView.addSubview(likesLabel)
        self.contentView.addSubview(viewsLabel)
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            authorLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),

            postImageView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 16),
            postImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            postImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),

            descriptionLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: likesLabel.topAnchor, constant: -16),
            
            likesLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            likesLabel.heightAnchor.constraint(equalToConstant: 30),
            likesLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/2),
            likesLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16),

            viewsLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            viewsLabel.topAnchor.constraint(equalTo: likesLabel.topAnchor),
            viewsLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/2),
            viewsLabel.bottomAnchor.constraint(equalTo: likesLabel.bottomAnchor)
        ])
    }
}
