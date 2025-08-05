//
//  SVGTestView.swift
//  BeaconSet
//
//  Created by 서충원 on 1/29/25.
//

import SwiftUI
import WebKit

internal struct SVGTestView: View {
    @State internal var svgString = 안산상공회의소뒤
    @State internal var toggleValue = false
    @State internal var isInitial = false
    
    internal var body: some View {
        ZStack {
            VStack {
                SVGWebView(svgString: $svgString, isInitial: $isInitial)
                    .ignoresSafeArea()
                Spacer()
                    .frame(height: 100)
            }
            VStack {
                HStack {
                    Button("Change Button") {
                        toggleValue.toggle()
                        isInitial = true
                        if toggleValue {
                            svgString = 안산상공회의소뒤.updateColor()
                        } else {
                            svgString = 안산상공회의소뒤
                        }
                    }
                    .font(.system(size: 14))
                    .foregroundStyle(.black)
                    .padding(10)
                    .background(Color(.systemGroupedBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
         
                Spacer()
            }
        }
    }
}

internal struct SVGWebView: UIViewRepresentable {
    @Binding internal var svgString: String
    @Binding internal var isInitial: Bool
    
    internal func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.isOpaque = false
        webView.backgroundColor = UIColor.gray
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.scrollView.showsVerticalScrollIndicator = false
        
        webView.scrollView.zoomScale = 1.0
        webView.scrollView.maximumZoomScale = 3.0
        webView.scrollView.minimumZoomScale = 1.0
        
        let htmlContent = """
        <html>
            <head>
                <style>
                    body, html {
                        height: 100%;
                        margin: 0;
                        display: flex;
                        justify-content: center;
                        align-items: center;
                        background-color: transparent;
                    }
                    svg {
                        max-width: 100%;
                        max-height: 100%;
                    }
                </style>
            </head>
            <body>
                \(svgString)
            </body>
        </html>
        """
        webView.loadHTMLString(htmlContent, baseURL: nil)
        
        return webView
    }
    
    internal func updateUIView(_ uiView: WKWebView, context: Context) {
        guard isInitial else { return } // 초기 호출 무시
        // JavaScript를 사용하여 SVG 요소를 업데이트
        let script = """
        var svgElement = document.querySelector('svg');
        var paths = svgElement.querySelectorAll('[fill="#848484"]');
        paths.forEach(function(path) {
            path.setAttribute('fill', 'blue');
        });
        """
        
        // JavaScript 코드 실행
        uiView.evaluateJavaScript(script, completionHandler: nil)
    }
}
