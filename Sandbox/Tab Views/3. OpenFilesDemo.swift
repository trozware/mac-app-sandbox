// This sample app accompanies my article on the Mac App Sandbox
// https://troz.net/post/2026/playing_mac_sandbox/
//
// Sarah Reichelt, March 2026

import SwiftUI
import UniformTypeIdentifiers

struct OpenFilesDemo: View {
  @State private var imageUrl: URL?
  @State private var showFileImporter = false
  @AppStorage("storedBookmark") private var storedBookmark: Data?

  var body: some View {
    VStack {
      Spacer()

      AsyncImage(url: imageUrl) { image in
        image
          .resizable()
          .aspectRatio(contentMode: .fit)
          .onAppear {
            if let imageUrl {
              saveBookmarkData(for: imageUrl)
              imageUrl.stopAccessingSecurityScopedResource()
            }
          }
      } placeholder: {
        ContentUnavailableView {
          Label("No Image Selected", systemImage: "photo")
        } description: {
          Text("Use either button below to select an image file.")
        }
      }
      .padding()

      Spacer()

      HStack {
        Button("Select Image using AppKit", systemImage: "app.grid") {
          selectAppKit()
        }

        Spacer()

        Button("Select image using SwiftUI", systemImage: "swift") {
          clearImage()
          showFileImporter = true
        }
      }
    }
    .padding()
    .fileImporter(
      isPresented: $showFileImporter,
      allowedContentTypes: [.image]
    ) { result in
      switch result {
      case .success(let url):
        let gotAccess = url.startAccessingSecurityScopedResource()
        if gotAccess {
          imageUrl = url
        }
      case .failure(let error):
        print("Image import failed: \(error.localizedDescription)")
      }
    }
    .onAppear(perform: loadImageUrlFromBookmark)
  }

  func selectAppKit() {
    let panel = NSOpenPanel()
    panel.allowedContentTypes = [.image]
    panel.message = "Select any image file…"

    clearImage()

    panel.begin { response in
      if response == .OK, let url = panel.url {
        imageUrl = url
      }
    }
  }

  func clearImage() {
    storedBookmark = nil
    imageUrl = nil
  }

  func saveBookmarkData(for url: URL) {
    if let bookmarkData = try? url.bookmarkData(options: .withSecurityScope) {
      storedBookmark = bookmarkData
    }
  }

  func loadImageUrlFromBookmark() {
    guard let storedBookmark else {
      return
    }

    var isStale = false
    guard
      let url = try? URL(
        resolvingBookmarkData: storedBookmark,
        options: [.withSecurityScope],
        relativeTo: nil,
        bookmarkDataIsStale: &isStale
      )
    else {
      return
    }

    let gotAccess = url.startAccessingSecurityScopedResource()
    if !gotAccess {
      return
    }

    imageUrl = url
    if isStale {
      saveBookmarkData(for: url)
    }
  }
}

#Preview {
  OpenFilesDemo()
}
