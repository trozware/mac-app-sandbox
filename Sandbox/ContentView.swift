// This sample app accompanies my article on the Mac App Sandbox
// https://troz.net/post/2026/playing_mac_sandbox/
//
// Sarah Reichelt, March 2026

import SwiftUI

struct ContentView: View {
  var body: some View {
    TabView {
      Tab("Default Save", systemImage: "gear") {
        DefaultSaveDemo()
      }

      Tab("Web View", systemImage: "network") {
        WebViewDemo()
      }

      Tab("Open Files", systemImage: "doc") {
        OpenFilesDemo()
      }

      Tab("Read Folders", systemImage: "folder") {
        ReadFoldersDemo()
      }
    }
    .frame(minWidth: 550, minHeight: 450)
  }
}

#Preview {
  ContentView()
}
