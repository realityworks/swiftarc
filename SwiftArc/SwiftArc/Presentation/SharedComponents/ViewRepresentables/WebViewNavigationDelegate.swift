//
//  WebViewNavigationDelegate.swift
//

import Foundation
import WebKit

class WebViewNavigationDelegate: NSObject, WKNavigationDelegate {
    var webView: WebView
    
    init(webView: WebView) {
        self.webView = webView
    }
    
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
    ) {
        let isProjecta = navigationAction.request.url?.absoluteString.contains("projecta.com.au")
        decisionHandler(isProjecta == true ? .allow : .cancel)
    }
    
    func webView(
        _ webView: WKWebView,
        didFinish navigation: WKNavigation!
    ) {
        self.webView.loaded = false
    }
}
