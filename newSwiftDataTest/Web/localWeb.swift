import SwiftUI
import WebKit

// 创建一个 UIViewRepresentable 类型的包装器
struct LocalWebView: UIViewRepresentable {
    let htmlFileName: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // 查找本地 HTML 文件的路径
        if let filePath = Bundle.main.path(forResource: htmlFileName, ofType: "html") {
            let fileURL = URL(fileURLWithPath: filePath)
            // 加载本地 HTML 文件
            uiView.loadFileURL(fileURL, allowingReadAccessTo: fileURL.deletingLastPathComponent())
        }
    }
}

// 定义 SwiftUI 视图
struct localWeb: View {
    var body: some View {
        // 使用 WebView 包装器加载本地 HTML 文件
        LocalWebView(htmlFileName: "canvas-zxt")
    }
}
#Preview {
    localWeb()
}
