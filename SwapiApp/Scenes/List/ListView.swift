//
//  ListView.swift
//  SwapiApp
//
//  Created by Ricardo González Pacheco on 31/08/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

struct CharacterViewInfo {
    let id: String
    let name: String
    let height: String
}

final class ListView: UIViewController {
    
    var charactersViewInfo: [CharacterViewInfo] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    var presenter: ListPresenterBasis?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        presenter?.viewIsReady()
    }
    
    fileprivate func setupView() {
        title = "Characters list"
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ListView: ListViewBasis {
    func failedCharactersRequest(message: String) {
        print(message)
    }
    
    func onShowCharactersList(charactersViewInfo: [CharacterViewInfo]) {
        self.charactersViewInfo = charactersViewInfo
    }
}

extension ListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.characterIsSelected(withIdentifier: charactersViewInfo[indexPath.row].id)
    }
}

extension ListView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charactersViewInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = {
            let cellIdentifier = "cellIdentifier"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) else {
                return UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
            }
            return cell
        }()
        
        cell.textLabel?.text = charactersViewInfo[indexPath.row].name
        cell.detailTextLabel?.text = charactersViewInfo[indexPath.row].height
        return cell
    }
}
