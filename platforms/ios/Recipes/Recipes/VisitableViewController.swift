import Turbolinks
import UIKit

class VisitableViewController: Turbolinks.VisitableViewController {
    var rightBarButtonUrl: URL?
    
    lazy var errorView: ErrorView = {
        let view = Bundle.main.loadNibNamed("ErrorView", owner: self, options: nil)!.first as! ErrorView
        view.translatesAutoresizingMaskIntoConstraints = false
        view.retryButton.addTarget(self, action: #selector(retry(_:)), for: .touchUpInside)
        return view
    }()
    
    func presentError(_ error: Error) {
        errorView.error = error
        view.addSubview(errorView)
        installErrorViewConstraints()
    }
    
    func installErrorViewConstraints() {
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: [], metrics: nil, views: [ "view": errorView ]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: [], metrics: nil, views: [ "view": errorView ]))
    }
    
    func retry(_ sender: AnyObject) {
        errorView.removeFromSuperview()
        reloadVisitable()
    }
    
    override func visitableDidRender() {
        super.visitableDidRender()
        visitableView.webView?.evaluateJavaScript("var nav = document.querySelector('[rel=\"mobile-navigation\"]'); nav && [nav.title, nav.href]") { (result, error) -> Void in
            if let titleAndUrl = result as? NSArray {
                let rightBarButtonTitle = titleAndUrl[0] as! String
                self.rightBarButtonUrl = URL(string: titleAndUrl[1] as! String)
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: rightBarButtonTitle, style: .plain, target: self, action: #selector(self.rightBarButtonTapped))
            }
        }
    }
    
    func rightBarButtonTapped() {
        (self.navigationController as! ApplicationController).navigateTo(url: self.rightBarButtonUrl!, action: .Advance);
    }
}
