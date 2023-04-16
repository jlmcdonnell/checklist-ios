//
//  ChecklistDataModel.swift
//  Checklist
//
//  Created by me on 16/04/2023.
//

import Foundation

class ChecklistDataModel: ObservableObject {
    @Published var items: [Checklist] = []
    
    func loadData() async {
        let loadedItems = await loadChecklists()
        self.items = loadedItems
    }
}
