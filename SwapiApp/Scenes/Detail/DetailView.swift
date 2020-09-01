//
//  DetailView.swift
//  SwapiApp
//
//  Created by Ricardo González Pacheco on 01/09/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

final class DetailView: UIViewController {
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        return table
    }()
    
    var presenter: DetailPresenterBasis?
    
    let characterIdentifier: String
    init(characterIdentifier: String) {
        self.characterIdentifier = characterIdentifier
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewIsReady(characterId: characterIdentifier)
    }
}

extension DetailView: DetailViewBasis {
    func onShowingCharacterData() {
        <#code#>
    }
    
    func onShowingRequestError(message: String) {
        print(message)
    }
}

extension DetailView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}
