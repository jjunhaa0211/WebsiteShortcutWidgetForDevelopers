//
//  MenuBarSettingView.swift
//  MuenBarYourApp
//
//  Created by 박준하 on 11/1/23.
//
import SwiftUI

struct MenuBarSettingView: View {
    @AppStorage("userName") private var userName: String = "YourUserName"
    @AppStorage("gitHubURL") private var gitHubURL: String = "https://github.com/jjunhaa0211"
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            TextField("Enter your name", text: $userName)
                .padding()
                .textFieldStyle(.roundedBorder)
            
            TextField("Enter GitHub URL", text: $gitHubURL)
                .padding()
                .textFieldStyle(.roundedBorder)
            
            Button("Update MenuBar") {
                if let appDelegate = NSApp.delegate as? AppDelegate {
                    let updatedItems = [(name: "GitHub", url: gitHubURL)]
                    appDelegate.updateMenuBarItems(updatedItems)
                }
            }
        }
        .padding()
    }
}

#Preview {
    MenuBarSettingView()
}
