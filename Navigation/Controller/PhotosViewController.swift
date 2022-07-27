//
//  PhotosViewController.swift
//  Navigation
//
//  Created by M M on 5/5/22.
//

import Foundation
import UIKit
import iOSIntPackage
import SnapKit

final class PhotosViewController: UIViewController {

    // MARK: - Variables

    private var dataSource: [String] = []
    private let facade = ImagePublisherFacade()
    private var photos: [UIImage] = []
    
    // MARK: - View Elements

    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "defaultCell")
        collection.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "photoCell")
        
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()

    let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        return layout
    } ()

    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photo Gallery"
        self.navigationController?.navigationBar.topItem?.backButtonTitle = "Back"
        self.navigationController?.navigationBar.tintColor = .systemBlue
        self.navigationController?.navigationBar.isHidden = false

        configureCollectionView()
        dataSource = fetchData()

        facade.subscribe(self)
        facade.addImagesWithTimer(time: 0.5, repeat: photos.count)
    }

    deinit {
        facade.removeSubscription(for: self)
        facade.rechargeImageLibrary()
    }

    private func configureCollectionView() {
        addSubviews()
        setConstraints()
    }

    private func setConstraints() {
        collectionView.snp.makeConstraints{ make in
            make.right.left.top.bottom.equalTo(view).inset(8)
        }
    }

    private func addSubviews() {
        view.addSubview(collectionView)
    }

    private func itemSize(for width: CGFloat, with spacing: CGFloat) -> CGSize {
        let neededWidth = width - 2 * spacing
        let itemWidth = floor(neededWidth / 3)
        return CGSize(width: itemWidth, height: itemWidth)
    }
}


// MARK: - Extensions

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotosCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "defaultCell", for: indexPath)
            cell.backgroundColor = .systemMint
            return cell
        }
        let photo = self.dataSource[indexPath.row]
        cell.backgroundColor = .systemGray6
        cell.setup(with: photo)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing
        return self.itemSize(for: collectionView.frame.width, with: spacing ?? 0)
    }

    func fetchData() -> [String] {
        (1...20).map{ String($0) }
    }
}

extension PhotosViewController: ImageLibrarySubscriber {
    func receive(images: [UIImage]) {
            photos = images
            collectionView.reloadData()
        }

    
}
