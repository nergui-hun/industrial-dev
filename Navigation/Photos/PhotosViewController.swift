//
//  PhotosViewController.swift
//  Navigation
//
//  Created by M M on 5/5/22.
//

import Foundation
import UIKit

class PhotosViewController: UIViewController {

    // MARK: - Variables

    private var dataSource: [String] = []
    
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
    }

    private func configureCollectionView() {
        addSubviews()
        setConstraints()
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8)
        ])
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
        let photo1 = String("1")
        let photo2 = String("2")
        let photo3 = String("3")
        let photo4 = String("4")
        let photo5 = String("5")
        let photo6 = String("6")
        let photo7 = String("7")
        let photo8 = String("8")
        let photo9 = String("9")
        let photo10 = String("10")
        let photo11 = String("11")
        let photo12 = String("12")
        let photo13 = String("13")
        let photo14 = String("14")
        let photo15 = String("15")
        let photo16 = String("16")
        let photo17 = String("17")
        let photo18 = String("18")
        let photo19 = String("19")
        let photo20 = String("20")
        return [photo1, photo2, photo3, photo4, photo5, photo6, photo7, photo8, photo9, photo10,
                photo11, photo12, photo13, photo14, photo15, photo16, photo17, photo18, photo19, photo20]
    }
}
