//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by M M on 6/6/22.
//

import Foundation
import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {

    //==========================PROPERTIES=================================//
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()

    //===========================INITIALIZERS=================================//
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(photoImageView)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //===========================METHODS=================================//
    /*
     1. private func setConstraints()
     2. override func prepareForReuse()
     3. func setup(with image: String)
     */
    private func setConstraints() {
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
