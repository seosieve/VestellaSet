//
//  SVGTestView.swift
//  BeaconSet
//
//  Created by 서충원 on 1/29/25.
//

import SwiftUI
import WebKit

public struct SVGTestView: View {
    public var body: some View {
        SVGWebView(svgString: 안산상공회의소뒤)
            .ignoresSafeArea()
    }
}

internal struct SVGWebView: UIViewRepresentable {
    internal let svgString: String
    
    internal func makeUIView(context: Context) -> some UIView {
        let webView = WKWebView()
        webView.isOpaque = false
        webView.backgroundColor = UIColor.gray
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.loadHTMLString(svgString.updateColor(), baseURL: nil)
        return webView
    }
    
    internal func updateUIView(_ uiView: UIViewType, context: Context) { }
}
