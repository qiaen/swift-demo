import SwiftUI

struct ScrollOffsetPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct TransparentButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .contentShape(Rectangle())
            .background(Color.clear)
    }
}

struct test5Scroll: View {
    var body: some View {
        NavigationView {
            ScrollView {
                GeometryReader { proxy in
                    if let distanceFromTop = proxy.bounds(of: .named("MyScrollView"))?.minY {
                        Text(distanceFromTop, format: .number)
                            .padding(.top, 120)
                            .foregroundStyle(.pink)
                            .navigationTitle("明明变了为什么检测不到")
                            .preference(key: ScrollOffsetPreferenceKey.self, value: distanceFromTop)
                    } else {
                        Text("检测无效")
                    }
                }
                ForEach(0 ..< 30) { index in
                    HStack {
                        Button(action: {
                            // Button action
                        }) {
                            Text("item --- \(index)")
                        }
                        .buttonStyle(TransparentButtonStyle())
                    }
                    .frame(width: 100, height: 40)
                }
            }
            .background(Color.black.opacity(0))
            .coordinateSpace(.named("MyScrollView"))
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                print("Scroll offset ----- \(value)")
            }
        }
    }
}

#Preview {
    test5Scroll()
}

