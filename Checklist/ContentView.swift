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
                    Spacer(minLength: 40)
                    ChecklistView(checklist: checklist)
                }
            }.frame(maxWidth: .infinity)
            Spacer(minLength: 80)
        }
    }
}

struct ChecklistView: View  {
    var checklist: Checklist
    
    @State
    var checkedItems = [Int: Bool]()
    
    var body: some View {
        VStack {
            HStack {
                Text(checklist.name)
                    .font(.system(size: 28))
                Spacer()
                Button("Reset", action: { checkedItems.removeAll() })
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 12))
            }
            
            ForEach(Array(checklist.items.enumerated()), id: \.offset) { i, item in
                let checked = checkedItems[i] ?? false
                let opacity = (checked) ? 0.3 : 1.0
                
                HStack(alignment: .firstTextBaseline) {
                    Text(
                        item.name
                    )
                        .font(.system(size: 24))
                        .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                    Spacer()
                    VStack(alignment: .trailing) {
                        ForEach(item.state, id: \.self) { state in
                            Text(state)
                                .font(.system(size: 24))
                        }
                    }.padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                }
                .background(Color(UIColor.systemGray6))
                .cornerRadius(16)
                .opacity(opacity)
                .onTapGesture {
                    let checked = checkedItems[i] ?? false
                    if (checked) {
                        for j in i...checkedItems.count {
                            checkedItems[j] = false
                        }
                    } else {
                        for j in 0...i {
                            checkedItems[j] = true
                        }
                    }
                }
            }
        }.frame(width: 500)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
