//
//  SavedTableViewCell.swift
//  Navigation
//
//  Created by M M on 4/10/23.
//

import Foundation
import UIKit
import StorageService
import SnapKit

final class SavedTableViewCell: UITableViewCell {

    // MARK: - Values

    var viewModel: SavedPostsCellVM? {
        willSet(viewModel) {
            guard let viewModel = viewModel else {
                print("hi")
                return
            }
            authorLabel.text = viewModel.author
            descriptionLabel.text = viewModel.postText
            postImageView.image = UIImage(named: viewModel.image)
            likesLabel.text = "Likes: \(viewModel.likes)"
            viewsLabel.text = "Views: \(viewModel.views)"
        }
    }


    // MARK: - View Elements

    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()

    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        return imageView
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()

    private let likesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        return label
    }()

    private let viewsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()



    // MARK: - init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    func set(post: Post) {
        self.authorLabel.text = post.author
        self.postImageView.image = UIImage(named: post.image)
        self.descriptionLabel.text = post.postText
        self.likesLabel.text = "Likes: \(post.likes)"
        self.viewsLabel.text = "Views: \(post.views)"
    }

    private func setupView() {
        let subviews = [authorLabel, postImageView, descriptionLabel, likesLabel, viewsLabel]
        subviews.forEach({ self.contentView.addSubview($0)})

        authorLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(16)
        }


        postImageView.snp.makeConstraints { make in
            make.top.equalTo(authorLabel.snp_bottomMargin).offset(16)
            make.width.height.equalTo(UIScreen.main.bounds.width)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(postImageView.snp_bottomMargin).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(likesLabel.snp_topMargin).offset(-16)
        }

        likesLabel.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().inset(16)
            make.height.equalTo(30)
            make.width.equalToSuperview().dividedBy(2)
        }

        viewsLabel.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(16)
            make.height.width.equalTo(likesLabel)
        }
    }
}

