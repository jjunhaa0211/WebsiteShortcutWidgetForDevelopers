import SwiftUI

struct GithubSettingView: View {
    @AppStorage("userName") private var userName: String = "YourUserName"
    @AppStorage("gitHubURL") private var gitHubURL: String = "https://github.com/jjunhaa0211"

    var body: some View {
        NavigationView {
            Form {
                Section() {
                    VStack(alignment: .leading, spacing: 20) {
                        Image(systemName: "globe")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.blue)
                        
                        Text("UserName or Github Setting")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    
                    TextField("Your Name", text: $userName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .padding(.vertical, 10)
                    
                    TextField("GitHub URL", text: $gitHubURL)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .padding(.vertical, 10)
                }
                
                Section {
                    Button(action: {
                        updateMenuBar()
                    }) {
                        Text("Update MenuBar")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
                .padding(.vertical, 20)
            }
            .navigationTitle("MenuBar Settings")
            .frame(minWidth: 600)
            .padding(20)
        }
    }
    
    func updateMenuBar() {
        if let appDelegate = NSApp.delegate as? AppDelegate {
            let updatedItems = [(name: userName, url: gitHubURL)]
            appDelegate.updateMenuBarItems(updatedItems)
        }
    }
}

struct MenuBarSettingView_Previews: PreviewProvider {
    static var previews: some View {
        GithubSettingView()
    }
}
