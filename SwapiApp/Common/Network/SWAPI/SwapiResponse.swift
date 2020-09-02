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
