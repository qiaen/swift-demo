//
//  Home.swift
//  newSwiftDataTest
//
//  Created by QIAEN on 2025/1/13.
//

import SwiftUI

struct Home: View {
    var body: some View {
        NavigationView {
            // List 在scrollView中无法显示
            List {
                
                NavigationLink {
                    CustomWebView(url: "http://localhost:1025/html/webview/view.html")
                        
                } label: {
                    Text("打开自定义地址")
                }
                NavigationLink {
                    CustomWebView(url: "http://localhost:1025/html/webview/full.html")
                        .ignoresSafeArea(.container)
                        
                    
                } label: {
                    Text("打开全屏")
                }
                NavigationLink {
                    CustomWebView(url: "https://staging.ofa.ai.kezhitech.com/dimh5/")
                        .ignoresSafeArea(.all)
                        .navigationBarBackButtonHidden()
                        
                } label: {
                    Text("次元学记")
                }
            }
            .navigationTitle("Web")
        }
    }
}

#Preview {
    Home()
}
