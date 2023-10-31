//
//  MuenBarYourAppApp.swift
//  MuenBarYourApp
//
//  Created by 박준하 on 10/31/23.
//

import SwiftUI

@main
struct BarHajApp: App {
    
    init() {
        if #unavailable(macOS 13.0) {
            @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
        }
    }
    
    @Environment(\.openURL) private var openURL
    
    var body: some Scene {
        
        if #available(macOS 13.0, *) {
            WindowGroup {
                ContentView()
            }
            MenuBarExtra(
                "userName", image: "MenuBarIcon")
            {
                Button("GitHub") {
                    if let url = URL(string: "https://github.com/jjunhaa0211") {
                        openURL(url)
                    }
                }.keyboardShortcut("1")
                
                Divider()
                
                Button("Bye userName") {
                    NSApplication.shared.terminate(nil)
                }.keyboardShortcut("q")
            }
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    @Environment(\.openURL) private var openURL
    
    var statusBarItem : NSStatusItem!
    var statusBarMenu : NSMenu!
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let statusBar = NSStatusBar.system
        
        self.statusBarItem = statusBar.statusItem(withLength: 30)
        self.statusBarItem.button?.image = NSImage(resource: .menuBarIcon)
        
        self.statusBarMenu = NSMenu()
        self.statusBarMenu.addItem(withTitle: "GitHub", action: #selector(openGithub), keyEquivalent: "2")
        self.statusBarMenu.addItem(withTitle: "Quit", action: #selector(NSApplication.shared.terminate), keyEquivalent: "q")
        
        self.statusBarItem.menu = self.statusBarMenu
    }
    
    @objc func openGithub() {
        if let url = URL(string: "https://github.com/jjunhaa0211") {
            openURL(url)
        }
    }
}
