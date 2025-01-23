//
//  TestScrollView.swift
//  newSwiftDataTest
//
//  Created by QIAEN on 2024/12/17.
//

import SwiftUI

class ScrollObserver1: ObservableObject {
    @Published var scrollOffset: CGFloat = 0
}

private struct OffsetPreferenceKey: PreferenceKey {
    
    static var defaultValue: CGPoint = .zero
    
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) { }
}

struct OffsettableScrollView1<T: View>: View {
    let axes: Axis.Set
    let showsIndicator: Bool
    let onOffsetChanged: (CGPoint) -> Void
    let content: T
    
    init(axes: Axis.Set = .vertical,
         showsIndicator: Bool = true,
         onOffsetChanged: @escaping (CGPoint) -> Void = { _ in },
         @ViewBuilder content: () -> T
    ) {
        self.axes = axes
        self.showsIndicator = showsIndicator
        self.onOffsetChanged = onOffsetChanged
        self.content = content()
    }
    
    var body: some View {
        ScrollView(axes, showsIndicators: showsIndicator) {
            GeometryReader { proxy in
                Color.clear.preference(
                    key: OffsetPreferenceKey.self,
                    value: proxy.frame(
                        in: .named("ScrollViewOrigin")
                    ).origin
                )
            }
            .frame(width: 0, height: 0)
            content
        }
        .padding(0)
        .scrollIndicators(.hidden)
        .coordinateSpace(name: "ScrollViewOrigin")
        .onPreferenceChange(OffsetPreferenceKey.self,
                            perform: onOffsetChanged)
    }
}
struct TestScrollBg: View {
    @State private var verticalOffset: CGFloat = 0.0
    @State private var barTitle = "播放中"
    var body: some View {
        NavigationView {
            GeometryReader { gemetry in
                let screenWidth = gemetry.size.width
                let screenHeight = gemetry.size.height
                ZStack(alignment: .top) {
                    // 顶部大图
                    Image("avatar4")
                        .resizable()
                        .scaledToFill()
                        .frame(width: screenWidth, height: verticalOffset > 0 ? (screenWidth + verticalOffset) : screenWidth)
                    
                    // 渐变色
                    let opacity = verticalOffset > 0 ? 0 : abs(verticalOffset) / screenWidth
                    HStack(){
                    }
                    .frame(width: screenWidth, height: screenWidth)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [.bgWhite.opacity(opacity), .bgWhite]), startPoint:.top, endPoint:.bottom)
                    )
                    // 下面黑色占用
                    HStack(){}
                        .frame(width: screenWidth, height: screenHeight - screenWidth)
                        .background(.bgWhite)
                        .padding(.top, screenWidth)
                    
                    OffsettableScrollView1 { point in
                        verticalOffset = point.y
                    } content: {
                        LazyVStack {
                            HStack(){
                            }
                            .frame(width: screenWidth, height: screenWidth - 100)
                            .background(.clear)
                            
                            
                            ForEach(0..<200) { index in
                                HStack{
                                    Text("Row number \(index)")
                                        .foregroundStyle(.txBlack)
                                        .padding()
                                        .padding(.leading)
                                    Spacer()
                                }
                                
                            }
                            
                        }
                    }
                }
                .background(.bgWhite)
                .ignoresSafeArea()
                .frame(width: screenWidth, height: screenHeight)
                
            }
//            .navigationBarTitle(verticalOffset < -200 ? barTitle : "", displayMode: .inline)
            .navigationBarTitle("播放中")
            .navigationBarHidden(verticalOffset > -200)
        }
    }
        
}

#Preview {
    TestScrollBg()
}
