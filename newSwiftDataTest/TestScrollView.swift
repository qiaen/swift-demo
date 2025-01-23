//
//  TestScrollView.swift
//  newSwiftDataTest
//
//  Created by QIAEN on 2024/12/17.
//

import SwiftUI

class ScrollObserver: ObservableObject {
    @Published var scrollOffset: CGFloat = 0
}

private struct OffsetPreferenceKey: PreferenceKey {
    
    static var defaultValue: CGPoint = .zero
    
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) { }
}

struct OffsettableScrollView<T: View>: View {
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
        .coordinateSpace(name: "ScrollViewOrigin")
        .onPreferenceChange(OffsetPreferenceKey.self,
                            perform: onOffsetChanged)
    }
}
struct TestScrollView: View {
    @State private var verticalOffset: CGFloat = 0.0
    
    var body: some View {
            
            VStack {
                Text("Offset: \(String(format: "%.2f", verticalOffset))")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.yellow)
                
                OffsettableScrollView { point in
                    verticalOffset = point.y
                } content: {
                    LazyVStack {
                        ForEach(0..<200) { index in
                            Text("Row number \(index)")
                                .padding()
                        }
                    }
                }
            }
        }
}

#Preview {
    TestScrollView()
}
