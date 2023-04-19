//
//  ProfileViewController.swift
//  Navigation
//
//  Created by M M on 4/29/22.
//

import UIKit
import StorageService
import SnapKit

final class ProfileViewController: UIViewController {
    
    // MARK: - Values
    
    private let viewModel: ProfileVMProtocol?
    
    // MARK: - View Elements
    
    let profileHeaderView: ProfileHeaderView = {
        let phView = ProfileHeaderView()
        phView.avatarImageView.isUserInteractionEnabled = true
        return phView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "defaultCell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "photoCell")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "postCell")
        
        tableView.sectionFooterHeight = 0
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.tableHeaderView = profileHeaderView
        
        return tableView
    }()
    
    // MARK: - init()
    
    init(viewModel: ProfileVMProtocol?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        self.navigationController?.navigationBar.isHidden = true
        
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func setupView() {
        
        view.addSubview(tableView)
        tableView.pin(to: self.view)
        
        profileHeaderView.snp.makeConstraints { make in
            make.width.equalTo(tableView)
            make.height.equalTo(250)
        }
        
        self.tableView.tableHeaderView?.layoutIfNeeded()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        view.addGestureRecognizer(tap)
        
        let profileImageViewTap = UITapGestureRecognizer(target: self, action: #selector(zoomInProfileImage(profileImageViewTap: )))
        profileHeaderView.avatarImageView.addGestureRecognizer(profileImageViewTap)
        
        let closePhotoButtonTap = UITapGestureRecognizer(target: self, action: #selector(zoomOutProfileImage(closePhotoButtonTap: )))
        profileHeaderView.closePhotoButton.addGestureRecognizer(closePhotoButtonTap)
        
    }
    
    @objc private func zoomInProfileImage(profileImageViewTap: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0, animations: {
            self.profileHeaderView.setAlphaViewConstraints(vc: self)
        }, completion: {_ in UIView.animate(withDuration: 0.5, animations: {
            self.profileHeaderView.zoomInUserPhoto(vc: self)
            self.profileHeaderView.layoutIfNeeded()
        }, completion: {_ in UIView.animate(withDuration: 0.3, animations: {
            self.profileHeaderView.showClosePhotoButton()
            self.profileHeaderView.layoutIfNeeded()
        })
        })})
    }
    
    @objc private func zoomOutProfileImage(closePhotoButtonTap: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.3, animations: {
            self.profileHeaderView.hideClosePhotoButton()
            self.profileHeaderView.layoutIfNeeded()
        }, completion: {_ in UIView.animate(withDuration: 0.5, animations: {
            self.profileHeaderView.zoomOutUserPhoto(vc: self)
            self.profileHeaderView.layoutIfNeeded()
        })})
    }
}



// MARK: - Extensions

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource, PhotosTableViewCellDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            guard let count = try? viewModel?.numberOfRows() else {
                preconditionFailure("No posts")
            }
            return count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)
                return cell
            }
            
            let cellVM = viewModel?.cellViewModel(forIndexPath: indexPath)
            cell.viewModel = cellVM
            
            return cell
            
        } else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as? PhotosTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)
                return cell
            }
            
            cell.delegate = self
            cell.setup()
            
            
            let redirectTap = UITapGestureRecognizer(target: self, action: #selector(redirectToGalleryAction))
            cell.addGestureRecognizer(redirectTap)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc func redirectToGalleryAction() {
        let photosViewController = PhotosViewController()
        self.navigationController?.pushViewController(photosViewController, animated: true)
    }
}
