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
        NavigationView {
            List {
                Section(header: Text("Add to MenuBar")) {
                    TextField("Enter your name", text: $userName)
                        .textFieldStyle(.roundedBorder)
                    
                    TextField("Enter GitHub URL", text: $gitHubURL)
                        .textFieldStyle(.roundedBorder)
                    
                    Button(action: {
                        addMenuBarItem()
                    }) {
                        Text("Add Link")
                    }
                    .disabled(userName.isEmpty || gitHubURL.isEmpty)
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
        menuBarItems.append((name: userName, url: gitHubURL))
        updateMenuBarItems(menuBarItems)
        saveMenuBarItems()
        userName = ""
        gitHubURL = ""
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
            .navigationTitle("GitHub Link")
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
