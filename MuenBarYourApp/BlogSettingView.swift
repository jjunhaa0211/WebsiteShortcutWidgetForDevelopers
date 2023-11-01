import SwiftUI

struct BlogSettingView: View {
    @AppStorage("userName") private var userName: String = "YourUserName"
    @AppStorage("BlogURL") private var blogURL: String = "https://goodjunha060211.tistory.com"

    var body: some View {
        NavigationView {
            Form {
                Section() {
                    VStack(alignment: .leading, spacing: 20) {
                        Image(systemName: "globe")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.blue)
                        
                        Text("Blog Setting")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    
                    TextField("Blog URL", text: $blogURL)
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
            let updatedItems = [(name: userName, url: blogURL)]
            appDelegate.updateMenuBarItems(updatedItems)
        }
    }
}

struct BlogSettingView_Previews: PreviewProvider {
    static var previews: some View {
        BlogSettingView()
    }
}
