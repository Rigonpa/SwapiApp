//
//  DetailView.swift
//  SwapiApp
//
//  Created by Ricardo González Pacheco on 01/09/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

final class DetailView: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis =  .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 0
        return stackView
    }()
    
    var presenter: DetailPresenterBasis?
    
    let characterIdentifier: String
    init(characterIdentifier: String) {
        self.characterIdentifier = characterIdentifier
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        presenter?.viewIsReady()
    }
    
    fileprivate func setupView() {
        title = "Detail"
        setupScrollView()
        setupStackView()
    }
    
    fileprivate func setupScrollView() {
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    fileprivate func setupStackView() {
        scrollView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
}

extension DetailView: DetailViewBasis {
    func onShowingCharacterData(characterData: CharacterData) {
        addSectionView(withTitle: "Name", andContent: characterData.name)
        addSectionView(withTitle: "BirthYear", andContent: characterData.birthYear)
        addSectionView(withTitle: "Height", andContent: characterData.height)
        addSectionView(withTitle: "Hair color", andContent: characterData.hairColor)
        addSectionView(withTitle: "Eye color", andContent: characterData.eyeColor)
        addSectionView(withTitle: "Skin color", andContent: characterData.skinColor)
        addSectionView(withTitle: "Mass", andContent: characterData.mass)
        addSectionView(withTitle: "Gender", andContent: characterData.gender.rawValue)
    }

    fileprivate func addSectionView(withTitle title: String, andContent content: String) {
        addTitleSection(title)
        addContentSection(content)
    }

    fileprivate func addTitleSection(_ title: String) {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 1
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = .lightGray
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "Helvetica", size: 23)
        stackView.addArrangedSubview(titleLabel)
    }

    fileprivate func addContentSection(_ content: String) {
        let contentLabel = UILabel()
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.text = content
        contentLabel.numberOfLines = 0
        contentLabel.font = UIFont(name: "Helvetica", size: 18)
        stackView.addArrangedSubview(contentLabel)
    }
}
