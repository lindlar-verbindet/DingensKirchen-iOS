//
//  WebView.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 07.09.21.
//

import SwiftUI
import WebView
import WebKit

class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void)
    {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        
        if navigationAction.request.url?.scheme == "tel" {
            UIApplication.shared.open(navigationAction.request.url!,
                                      options: [:],
                                      completionHandler: nil)
            decisionHandler(.cancel)
        } else if navigationAction.request.url?.scheme == "mailto" {
            UIApplication.shared.open(navigationAction.request.url!,
                                      options: [:],
                                      completionHandler: nil)
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
}

struct WebView: UIViewRepresentable {
    
    var urlString: String
    var navTitle: String = ""
    
    func makeUIView(context: Context) -> some WKWebView {
        guard let url = URL(string: urlString) else { return WKWebView() }
        
        let request = URLRequest(url: url)
        let webView = WKWebView()
        
        webView.navigationDelegate = context.coordinator
        webView.uiDelegate = context.coordinator
        
        webView.configuration.defaultWebpagePreferences.allowsContentJavaScript = true
        webView.load(request)
        
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
}

struct DKWebView: View {
    
    @State var urlString: String
    
    @State var navTitle:String = ""
    
    var body: some View {
        WebView(urlString: urlString)
    }
    
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        DKWebView(urlString: "https://pixelskull.de")
    }
}
