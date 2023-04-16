//
//  ContentView.swift
//  Checklist
//
//  Created by me on 16/04/2023.
//

import SwiftUI

struct ContentView: View {
    @State
    private var checklists: Array<Checklist> = []
    
    var body: some View {
        ChecklistGroup(checklists: checklists)
            .padding()
            .task {
                checklists = loadChecklists()
            }
    }
}

struct ChecklistGroup: View {
    var checklists: Array<Checklist>
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(checklists) { checklist in
                    ChecklistView(checklist: checklist)
                }
            }.frame(maxWidth: .infinity)
        }
    }
}

struct ChecklistView: View  {
    var checklist: Checklist
    
    var body: some View {
        VStack {
            Text(checklist.name)
            ForEach(Array(checklist.items.enumerated()), id: \.offset) { i, item in
                HStack {
                    Text(
                        item.name
                    ).padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                    Spacer()
                    HStack {
                        ForEach(item.state, id: \.self) { state in
                            Text(state)
                        }
                    }.padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                }
                .background(Color(UIColor.systemGray6))
                .frame(width: 330)
                .cornerRadius(16)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
