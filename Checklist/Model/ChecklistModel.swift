//
//  ChecklistModel.swift
//  Checklist
//
//  Created by me on 16/04/2023.
//

import Foundation

struct Checklist: Codable, Identifiable {
    let name: String
    let items: Array<CheckItem>
    let id: Int
}

struct CheckItem: Codable, Identifiable {
    let name: String
    let state: [String]
    let id: Int
}

func loadChecklists() -> Array<Checklist> {
    guard let url = Bundle.main.url(forResource: "checklists", withExtension: "json") else {
        print("No")
        return Array()
    }
    do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        return try decoder.decode(Array<Checklist>.self, from: data)
    } catch {
        print("No? \(error)")
    }
    return Array()
}
