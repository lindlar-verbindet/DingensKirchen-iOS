//
//  WebView.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 07.09.21.
//

import SwiftUI
import WebView

struct DKWebView: View {
    
    @State var urlString: String
    @StateObject var webViewStore = WebViewStore()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            WebView(webView: webViewStore.webView)
        }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("")
                }
                ToolbarItemGroup(placement: .bottomBar) {
                    Spacer()
                    Button(action: goBack) {
                        Image(systemName: "chevron.backward")
                            .accentColor(canGoBack() ? .tertiaryHighlight : .gray)
                    }
                    .disabled(!canGoBack())
                    Button(action: goForward) {
                        Image(systemName: "chevron.forward")
                            .accentColor( canGoForward() ? .tertiaryHighlight : .gray)
                    }
                    .disabled(!canGoForward())
                }
            }
            .onAppear {
                self.webViewStore.webView
                    .load(URLRequest(url: URL(string: urlString)!))
            }
            .navigationTitle(webViewStore.webView.title ?? "")
    }
    
    private func canGoBack() -> Bool {
        return webViewStore.webView.canGoBack
    }
    
    private func goBack() {
        webViewStore.webView.goBack()
    }
    
    private func canGoForward() -> Bool {
        return webViewStore.webView.canGoForward
    }
    
    private func goForward() {
        webViewStore.webView.goForward()
    }
    
    
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        DKWebView(urlString: "https://pixelskull.de")
    }
}
