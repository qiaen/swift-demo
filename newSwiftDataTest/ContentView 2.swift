//
//  ContentView.swift
//  newSwiftDataTest
//
//  Created by QIAEN on 2024/12/12.
//

import SwiftUI
import SwiftData
import WidgetKit

struct ScrollChange: View {
    @State var sctop: CGFloat = 0.0
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    GeometryReader { proxy in
                        Color.clear.preference(key: ScrollOffsetPreferenceKey.self, value: proxy.frame(in: .named("MyScrollView")).minY)
                    }
                    .frame(height: 0) // 隐藏的 GeometryReader
                    Text("距离顶部: \(sctop)")
                        .padding(.top, 120)
                        .foregroundStyle(.pink)
                        .navigationTitle("明明变了为什么检测不到")
                    
                    ForEach(0 ..< 30) { index in
                        HStack {
                            Button(action: {
                                // 按钮操作
                            }) {
                                Text("item --- \(index)")
                            }
                            .frame(width: 100, height: 40)
                        }
                    }
                }
            }
            .background(Color.clear)
            .coordinateSpace(name: "MyScrollView")
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                print("Scroll offset ----- \(value)")
                sctop = value
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: false)
}
