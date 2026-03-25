// This sample app accompanies my article on the Mac App Sandbox
// https://troz.net/post/2026/playing_mac_sandbox/
//
// Sarah Reichelt, March 2026

import SwiftUI

struct ReadFoldersDemo: View {
  @State private var filesList: [String] = []

  var body: some View {
    VStack {
      HStack {
        Button("Read /usr/") {
          readFiles(in: "/usr/")
        }

        Spacer()

        Button("Read /opt/") {
          readFiles(in: "/opt/")
        }
      }
      .padding()

      Text(filesList.joined(separator: "\n"))

      Spacer()
    }
  }

  func readFiles(in folder: String) {
    let fileManager = FileManager.default

    do {
      let contents = try fileManager.contentsOfDirectory(atPath: folder)
      filesList = contents
    } catch {
      print(error)
    }
  }
}

#Preview {
  ReadFoldersDemo()
}
