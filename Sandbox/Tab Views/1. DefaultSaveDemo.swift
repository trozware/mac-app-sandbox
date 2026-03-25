// This sample app accompanies my article on the Mac App Sandbox
// https://troz.net/post/2026/playing_mac_sandbox/
//
// Sarah Reichelt, March 2026

import SwiftUI

struct DefaultSaveDemo: View {
  @State private var filePath = ""

  var body: some View {
    VStack(spacing: 30) {
      Button(
        "Save Test String",
        systemImage: "square.and.arrow.down"
      ) {
        saveTestString()
      }

      Text(filePath)

      if !filePath.isEmpty {
        Button(
          "Show File",
          systemImage: "magnifyingglass"
        ) {
          showFileInFinder()
        }
      }

      Spacer()
    }
    .padding()
  }

  func saveTestString() {
    let docsUrl = URL.documentsDirectory
    let fileUrl = docsUrl.appendingPathComponent("save_test.txt")

    let saveString = """
      This is a test.
      Where do you think it will save?
      """

    try? saveString
      .write(
        to: fileUrl,
        atomically: true,
        encoding: .utf8
      )

    filePath = fileUrl.path
  }

  func showFileInFinder() {
    guard !filePath.isEmpty else {
      return
    }

    let folderUrl = URL(filePath: filePath)
      .deletingLastPathComponent()
    NSWorkspace.shared.open(folderUrl)
  }
}

#Preview {
  DefaultSaveDemo()
}
