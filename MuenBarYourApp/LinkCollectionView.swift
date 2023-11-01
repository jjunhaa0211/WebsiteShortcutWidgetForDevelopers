import SwiftUI

struct LinkCollectionView: View {
    @State private var titleName: String = ""
    @State private var websiteURL: String = ""
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
        NavigationView {
            List {
                Section(header: Text("Add to MenuBar")) {
                    TextField("Enter your title name", text: $titleName)
                        .textFieldStyle(.roundedBorder)
                    
                    TextField("Enter Website URL", text: $websiteURL)
                        .textFieldStyle(.roundedBorder)
                    
                    Button(action: {
                        addMenuBarItem()
                    }) {
                        Text("Add Link")
                    }
                    .disabled(titleName.isEmpty || websiteURL.isEmpty)
                }
                
                Section(header: Text("Links in MenuBar")) {
                    ForEach(menuBarItems.indices, id: \.self) { index in
                        LinkRowView(item: menuBarItems[index])
                    }
                }
            }
            .navigationTitle("Menu Links")
            .frame(minWidth: 600)
        }
    }
    
    func addMenuBarItem() {
        menuBarItems.append((name: titleName, url: websiteURL))
        updateMenuBarItems(menuBarItems)
        saveMenuBarItems()
        titleName = ""
        websiteURL = ""
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

struct LinkRowView: View {
    let item: (name: String, url: String)
    
    var body: some View {
        NavigationLink(destination: LinkDetailView(url: item.url)) {
            Text(item.name)
        }
    }
}

struct LinkDetailView: View {
    let url: String
    
    var body: some View {
        WebView(url: url)
            .navigationTitle("webSite Link")
    }
}

struct WebView: View {
    let url: String
    
    var body: some View {
        VStack {
            Text("Website: \(url)")
                .font(.title)
            Button("Open in Browser") {
                if let urlObj = URL(string: url) {
                    NSWorkspace.shared.open(urlObj)
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(Color.white)
            .cornerRadius(8.0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LinkCollectionView()
    }
}
