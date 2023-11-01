//
//  MuenBarYourAppApp.swift
//  MuenBarYourApp
//
//  Created by 박준하 on 10/31/23.
//

import SwiftUI

@main
struct BarHajApp: App {
    @AppStorage("userName") private var userName = "YourUserName"
    @AppStorage("gitHubURL") private var gitHubURL = "https://github.com/jjunhaa0211"

    var body: some Scene {
        WindowGroup {
            HStack {
                LinkCollectionView()
                MenuBarSettingView()
            }
        }
        MenuBarExtra("userName", image: "MenuBarIcon") {
            Button("GitHub - \(userName)") {
                if let url = URL(string: gitHubURL) {
                    NSWorkspace.shared.open(url)
                }
            }.keyboardShortcut("1")

            Divider()

            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }.keyboardShortcut("q")
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusBarItem: NSStatusItem!
    var statusBarMenu: NSMenu!
    var menuBarItems: [(name: String, url: String)] = []
    let menuBarItemsKey = "MenuBarItems"

    func applicationDidFinishLaunching(_ notification: Notification) {
        let statusBar = NSStatusBar.system
        statusBarItem = statusBar.statusItem(withLength: NSStatusItem.variableLength)
        statusBarItem.button?.title = "App"
        statusBarMenu = NSMenu(title: "Cap Status Bar Menu")
        statusBarItem.menu = statusBarMenu

        if let savedMenuBarItems = UserDefaults.standard.array(forKey: menuBarItemsKey) as? [[String: String]] {
            for item in savedMenuBarItems {
                if let name = item["name"], let url = item["url"] {
                    menuBarItems.append((name: name, url: url))
                }
            }
        }

        for item in menuBarItems {
            let menuItem = NSMenuItem(title: item.name, action: #selector(openUrl(_:)), keyEquivalent: "")
            menuItem.representedObject = item.url
            statusBarMenu.addItem(menuItem)
        }
        
        statusBarMenu.addItem(NSMenuItem.separator())
        statusBarMenu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.shared.terminate(_:)), keyEquivalent: "q"))
    }
    
    func updateMenuBarItems(_ items: [(name: String, url: String)]) {
        statusBarMenu.removeAllItems()

        for item in items {
            let menuItem = NSMenuItem(title: item.name, action: #selector(openUrl(_:)), keyEquivalent: "")
            menuItem.representedObject = item.url
            statusBarMenu.addItem(menuItem)
        }

        statusBarMenu.addItem(NSMenuItem.separator())
        statusBarMenu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.shared.terminate(_:)), keyEquivalent: "q"))
    }
    
    @objc func openUrl(_ sender: NSMenuItem) {
        if let urlString = sender.representedObject as? String, let url = URL(string: urlString) {
            NSWorkspace.shared.open(url)
        }
    }
}
