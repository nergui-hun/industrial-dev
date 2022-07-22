//
//  ProfileViewController.swift
//  Navigation
//
//  Created by M M on 4/29/22.
//

import UIKit
import StorageService
import SnapKit

class ProfileViewController: UIViewController {

    // MARK: - Variables

    var dataSource: [Post] = []
    var userService: UserService
    var login: String?

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
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: ProfileHeaderView.identifier)
        
        tableView.sectionFooterHeight = 0
        tableView.estimatedRowHeight = UITableView.automaticDimension

        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()


    // MARK: - Initializers
    init(userService: UserService, login: String) {
        self.userService = userService
        self.login = login
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

        configureTableView()
        dataSource = fetchData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    private func configureTableView() {
        view.addSubview(tableView)
        
        setConstraints()
        self.tableView.tableHeaderView?.layoutIfNeeded()

        let tap = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        view.addGestureRecognizer(tap)

        let profileImageViewTap = UITapGestureRecognizer(target: self, action: #selector(zoomInProfileImage(profileImageViewTap: )))
        profileHeaderView.avatarImageView.addGestureRecognizer(profileImageViewTap)

        let closePhotoButtonTap = UITapGestureRecognizer(target: self, action: #selector(zoomOutProfileImage(closePhotoButtonTap: )))
        profileHeaderView.closePhotoButton.addGestureRecognizer(closePhotoButtonTap)

    }

    func setConstraints() {
        tableView.pin(to: self.view)
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

    @objc private func zoomOutProfileImage(closePhotoButtonTap: UITapGestureRecognizer) {        UIView.animate(withDuration: 0.3, animations: {
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
            return self.dataSource.count
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
            let post = self.dataSource[indexPath.row]
            cell.set(post: post)
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


    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: ProfileHeaderView.self)) as? ProfileHeaderView else {
                return nil
            }

            if let currentUser = userService.showUserInfo(login: login!) {
            headerView.fullNameLabel.text = currentUser.fullName
            headerView.avatarImageView.image = currentUser.avatar
            headerView.statusLabel.text = currentUser.status
            }
            return headerView
        } else {
            return nil
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 250
        } else {
            return 0
        }
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }

    @objc func redirectToGalleryAction() {
        let photosViewController = PhotosViewController()
        self.navigationController?.pushViewController(photosViewController, animated: true)
    }
}

extension ProfileViewController {

    func fetchData() -> [Post] {
        let post1 = Post(author: "Нетология. Меряем карьеру через образование.", description: "От 'Hello, World' до первого сложного iOS-приложения - всего один курс. Если чувствуете в себе силу для покорения топов AppStore - пора начинать действовать! Профессия «iOS-разработчик» - тот самый путь, по которому стоит пройти по самого конца. Вы научитесь создавать приложения на языке Swift с нуля: от начинки до интерфейса. Чтобы закрепить знания на практике, каждый студент подготовит дипломную работу - VK-like приложение с возможностью публиковать фотографии, использовать фильтры, ставить лайки и подписываться на других пользователей.", image: "camel", likes: 766, views: 893)

        let post2 = Post(author: "Cats TV", description: "Bald cats are very cute", image: "bald", likes: 233, views: 234)
        let post3 = Post(author: "Mongolia TV", description: "Mongolian house", image: "ger", likes: 34, views: 354)
        let post4 = Post(author: "Rock TV", description: "The HU", image: "hu", likes: 33, views: 45)

        return [post1, post2, post3, post4]
    }
}
