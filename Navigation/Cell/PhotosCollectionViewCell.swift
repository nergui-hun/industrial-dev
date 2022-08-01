//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by M M on 6/6/22.
//

import Foundation
import UIKit

final class PhotosCollectionViewCell: UICollectionViewCell {


    // MARK: - View Elements

    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    } ()


    // MARK: - init

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - Methods

    private func setupView() {
        self.contentView.addSubview(photoImageView)
        photoImageView.pin(to: self.contentView)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.photoImageView.image = nil
    }

    func setup(with image: String) {
        self.photoImageView.image = UIImage(named: image)
    }
}
