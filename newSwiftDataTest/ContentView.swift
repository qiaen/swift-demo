//
//  ContentView.swift
//  newSwiftDataTest
//
//  Created by QIAEN on 2024/12/12.
//

import SwiftUI
import SwiftData
import WidgetKit

struct ContentView: View {
    @State var sctop: CGFloat = 0.0
    var body: some View {
        NavigationView {
            List {
                NavigationLink {
                    CustomWebView(url: "http://localhost:1025/html/webview/full.html")
                        .ignoresSafeArea(.container)
                } label: {
                    Text("打开全屏")
                }
                NavigationLink {
                    CustomWebView(url: "https://threejs.org/examples/#webgl_animation_keyframes")
                        .ignoresSafeArea()
                    
                } label: {
                    Text("打开3D")
                }
                NavigationLink {
                    localWeb()
                } label: {
                    Text("打开本地html")
                }
                
            }
            .navigationBarTitle("Home")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: false)
}
