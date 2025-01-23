import SwiftUI
import WebKit

class MessageHandler: NSObject, WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let web = message.webView else {
            return
        }
        
        if message.name == "updateTitle" {
            if let body = message.body as? String {
                // 处理消息
                print(body)
                web.evaluateJavaScript("windowUserFunc('hello，I am App！')")
            }
        }
    }
}

struct WebView: UIViewRepresentable {
    let url: URL
    @Binding var isLoading: Bool
    @Binding var loadError: Error?
    @Binding var pageTitle: String
    
    
    
    func makeUIView(context: Context) -> WKWebView {
        let webConfiguration = WKWebViewConfiguration()
        // 配置相关属性以隐藏导航元素
        webConfiguration.allowsInlineMediaPlayback = true
        webConfiguration.mediaPlaybackRequiresUserAction = false
//        webConfiguration.supportsMultipleWindows = false
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        let request = URLRequest(url: url)
        let messageHandler = MessageHandler()
        webView.configuration.userContentController.add(messageHandler, name: "updateTitle")
        webView.load(request)
        return webView
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "updateTitle", let param = message.body as? String {
            // 在这里处理从 JavaScript 传递过来的参数
            print("Received message from JS: \(param)")
            
        }
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        // 可用于更新 UIView，这里暂时不进行更新操作
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            parent.isLoading = true
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.isLoading = false
            if let title = webView.title {
                DispatchQueue.main.async {
                    print("-----\(title)")
                    self.parent.pageTitle = title
                }
            }
        }

        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            parent.isLoading = false
            parent.loadError = error
        }
    }
}

struct CustomWebView: View {
    @State var url: String
    
    @State private var isLoading = false
    @State private var loadError: Error?
    @State private var pageTitle = ""

    var body: some View {
        VStack {
            if isLoading {
                ProgressView()
            }
            if let error = loadError {
                Text("Error loading page: \(error.localizedDescription)")
            }
            
            WebView(url: URL(string: url)!, isLoading: $isLoading, loadError: $loadError, pageTitle: $pageTitle)
                .ignoresSafeArea()
               
//            Button("点击调用JS方法", action: {
////                WebView.evaluateJavaScript("gotoshopDetail()")
//            })
        }
//            .navigationBarTitle(pageTitle, displayMode: .inline)
        
    }
}
#Preview {
    Home()
}
