import UIKit
import WebKit

protocol AuthenticationControllerDelegate: class {
    func authenticationControllerDidAuthenticate(_ authenticationController: AuthenticationController)
}

class AuthenticationController: UIViewController {
    var url: URL?
    var webViewConfiguration: WKWebViewConfiguration?
    weak var delegate: AuthenticationControllerDelegate?
    
    lazy var webView: WKWebView = {
        let configuration = self.webViewConfiguration ?? WKWebViewConfiguration()
        let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        // spoof a real browser so that Google's OAuth page doesn't block us
        webView.customUserAgent = "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36"
        
        webView.navigationDelegate = self
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webView)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: [], metrics: nil, views: [ "view": webView ]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: [], metrics: nil, views: [ "view": webView ]))
        
        if let url = self.url {
            webView.load(URLRequest(url: url))
        }
    }
}

extension AuthenticationController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        let URL = navigationAction.request.url
        if URL?.path == "/users/auth/google_oauth2/callback" {
            decisionHandler(.cancel)
            delegate?.authenticationControllerDidAuthenticate(self)
            
            // Have the app load this URL
            (delegate as! ApplicationController).navigateTo(url: URL!, action: .Replace)
            return
        }
        
        decisionHandler(.allow)
    }
}
