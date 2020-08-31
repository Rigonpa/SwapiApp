//
//  ListEntity.swift
//  SwapiApp
//
//  Created by Ricardo González Pacheco on 31/08/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

// MARK: - SwapiResponse
struct SwapiResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [CharacterData]
}

// MARK: - Result
struct CharacterData: Codable {
    let name, height, mass, hairColor: String
    let skinColor, eyeColor, birthYear: String
    let gender: Gender
    let homeworld: String
    let films, species, vehicles, starships: [String]
    let created, edited: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name, height, mass
        case hairColor = "hair_color"
        case skinColor = "skin_color"
        case eyeColor = "eye_color"
        case birthYear = "birth_year"
        case gender, homeworld, films, species, vehicles, starships, created, edited, url
    }
}

extension CharacterData {
    var identifier: String {
        return String(url.split(separator: "/").last ?? "")
    }
}

enum Gender: String, Codable {
    case female = "female"
    case male = "male"
    case nA = "n/a"
}
