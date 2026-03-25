// This sample app accompanies my article on the Mac App Sandbox
// https://troz.net/post/2026/playing_mac_sandbox/
//
// Sarah Reichelt, March 2026

import SwiftUI
import WebKit

struct WebViewDemo: View {
  @State private var page = WebPage()

  var body: some View {
    WebView(page)
      .border(Color.gray.opacity(0.5))
      .padding()
      .onAppear(perform: loadHTML)
  }

  func loadHTML() {
    let html = """
      <h1>Header</h1>

      <p>Here is some <strong>HTML</strong> text.</p>

      <p>
        <a href="https://troz.net">troz.net</a>
      </p>
      """

    page.load(html: html, baseURL: URL(string: "about:blank")!)
  }
}

#Preview {
  WebViewDemo()
}
