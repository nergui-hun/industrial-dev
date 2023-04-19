//
//  SavedViewController.swift
//  Navigation
//
//  Created by M M on 2/25/23.
//

import Foundation
import UIKit
import SnapKit

final class SavedViewController: UIViewController{

    
    // MARK: - Values
    private var posts: [SavedPosts] = []

    // MARK: - View Elements

    private lazy var table: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(SavedTableViewCell.self, forCellReuseIdentifier: String(describing: SavedTableViewCell.self))
        tableView.separatorInset = .zero
        tableView.separatorStyle = .none
        return tableView
    } ()

    // MARK: - Methods

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CoreDataManager.shared.getContext()
        table.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        setupView()
    }

    private func setupView() {
        view.addSubview(table)

        table.snp.makeConstraints { make in
            make.top.bottom.right.left.equalToSuperview()
        }

        let searchButton = UIBarButtonItem(title: "Поиск по автору", style: .plain, target: self, action: #selector(searchByAuthor))
        searchButton.tintColor = .blue
        self.navigationItem.rightBarButtonItem = searchButton

        let clearFilterButton = UIBarButtonItem(title: "Очистить фильтр", style: .plain, target: self, action: #selector(clearFilter))
        clearFilterButton.tintColor = .blue
        self.navigationItem.leftBarButtonItem = clearFilterButton

        
    }

    @objc func searchByAuthor() {
        let alert = UIAlertController(title: "Поиск по автору", message: "Введите имя автора", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Применить", style: .default, handler: {_ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else {
                return
            }

            self.updateSearchResults(author: text)
        }))
        present(alert, animated: true)
    }

    @objc func clearFilter() {
        CoreDataManager.shared.getContext()
        table.reloadData()
    }

    private func updateSearchResults(author: String) {
        posts = CoreDataManager.shared.getPosts(author: author)
        table.reloadData()
    }

    // MARK: - Observers

}

// MARK: - Extensions

extension SavedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.shared.posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SavedTableViewCell.self), for: indexPath)
                as? SavedTableViewCell else { return UITableViewCell() }
        cell.viewModel = SavedPostsCellVM(post: CoreDataManager.shared.posts[indexPath.row])
        
        return cell
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let deleteAction = UIContextualAction(style: .destructive, title: nil, handler: { [weak self] (_, _, success: (Bool) -> Void) in
            success(true)

            let post = CoreDataManager.shared.posts[indexPath.row]
            CoreDataManager.shared.deletePost(post: post)
            tableView.deleteRows(at: [indexPath], with: .fade)
        })
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

}
