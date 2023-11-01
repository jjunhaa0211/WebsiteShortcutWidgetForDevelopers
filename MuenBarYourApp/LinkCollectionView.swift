//
//  ContentView.swift
//  MuenBarYourApp
//
//  Created by 박준하 on 10/31/23.
//
import SwiftUI

struct LinkCollectionView: View {
    @State private var userName: String = ""
    @State private var gitHubURL: String = ""
    @State private var menuBarItems: [(name: String, url: String)] = []
    @State private var showingAlert = false
    
    init() {
        if let savedMenuBarItems = UserDefaults.standard.array(forKey: "MenuBarItems") as? [[String: String]] {
            for item in savedMenuBarItems {
                if let name = item["name"], let url = item["url"] {
                    menuBarItems.append((name: name, url: url))
                }
            }
        }
    }

    var body: some View {
        VStack {
            TextField("Enter your name", text: $userName)
                .padding()
                .textFieldStyle(.roundedBorder)

            TextField("Enter GitHub URL", text: $gitHubURL)
                .padding()
                .textFieldStyle(.roundedBorder)

            Button("Add to MenuBar") {
                if userName.isEmpty || gitHubURL.isEmpty {
                    showingAlert = true
                } else {
                    menuBarItems.append((name: userName, url: gitHubURL))
                    updateMenuBarItems(menuBarItems)
                    saveMenuBarItems()
                    userName = ""
                    gitHubURL = ""
                }
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Error"), message: Text("Please enter both your name and GitHub URL"), dismissButton: .default(Text("OK"))
                )
            }
        }
        .padding()

        List(menuBarItems.indices, id: \.self) { index in
            Button(action: {
                if let urlObj = URL(string: menuBarItems[index].url) {
                    NSWorkspace.shared.open(urlObj)
                }
            }) {
                Text(menuBarItems[index].name)
            }
        }
    }

    func saveMenuBarItems() {
        let itemsToSave = menuBarItems.map { item in
            ["name": item.name, "url": item.url]
        }
        UserDefaults.standard.set(itemsToSave, forKey: "MenuBarItems")
    }
    
    func updateMenuBarItems(_ items: [(name: String, url: String)]) {
        menuBarItems = items
    }
}

#Preview {
    LinkCollectionView()
}
