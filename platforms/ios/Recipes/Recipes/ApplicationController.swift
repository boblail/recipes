import UIKit
import WebKit
import Turbolinks

class ApplicationController: UINavigationController {
//    fileprivate let url = URL(string: "http://localhost:3000/my-recipes")!
    fileprivate let url = URL(string: "https://lailrecipes.herokuapp.com/my-recipes")!
    fileprivate let webViewProcessPool = WKProcessPool()
    
    fileprivate var application: UIApplication {
        return UIApplication.shared
    }
    
    fileprivate lazy var webViewConfiguration: WKWebViewConfiguration = {
        let configuration = WKWebViewConfiguration()
        configuration.processPool = self.webViewProcessPool
        configuration.applicationNameForUserAgent = "RecipesApp"
        return configuration
    }()
    
    fileprivate lazy var session: Session = {
        let session = Session(webViewConfiguration: self.webViewConfiguration)
        session.delegate = self
        return session
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentVisitableForSession(session, url: url)
    }
    
    fileprivate func presentVisitableForSession(_ session: Session, url: URL, action: Action = .Advance) {
        let visitable = VisitableViewController(url: url)
        
        for case let previousVisitable as VisitableViewController in viewControllers {
            if previousVisitable.visitableURL.path == url.path {
                popToViewController(previousVisitable, animated: true)
                previousVisitable.visitableURL = url
                session.visit(previousVisitable)
                return
            }
        }
        
        if action == .Advance {
            pushViewController(visitable, animated: true)
        } else if action == .Replace {
            popViewController(animated: false)
            pushViewController(visitable, animated: false)
        }
        
        session.visit(visitable)
    }
    
    func navigateTo(path: String, action: Action = .Advance) {
        navigateTo(url: URL(string: url.absoluteString + path )!, action: action)
    }
    
    func navigateTo(url: URL, action: Action = .Advance) {
        presentVisitableForSession(session, url: url, action: action)
    }
    
    fileprivate func presentAuthenticationController(url: URL) {
        let authenticationController = AuthenticationController()
        authenticationController.delegate = self
        authenticationController.webViewConfiguration = webViewConfiguration
        authenticationController.url = url
        authenticationController.title = "Sign in"
        
        let authNavigationController = UINavigationController(rootViewController: authenticationController)
        present(authNavigationController, animated: true, completion: nil)
    }
}

extension ApplicationController: SessionDelegate {
    func session(_ session: Session, didProposeVisitToURL URL: Foundation.URL, withAction action: Action) {
        if URL.path == "/users/auth/google_oauth2" {
            presentAuthenticationController(url: URL)
        } else {
            print( URL.query ?? "N/A" )
            if URL.query?.contains("q=") ?? false {
                presentVisitableForSession(session, url: URL, action: .Replace)
            } else {
                presentVisitableForSession(session, url: URL, action: action)
            }
        }
    }
    
    func session(_ session: Session, didFailRequestForVisitable visitable: Visitable, withError error: NSError) {
        NSLog("ERROR: %@", error)
        guard let viewController = visitable as? VisitableViewController, let errorCode = ErrorCode(rawValue: error.code) else { return }
        
        switch errorCode {
        case .httpFailure:
            let statusCode = error.userInfo["statusCode"] as! Int
            switch statusCode {
            case 401:
                presentAuthenticationController(url: url.appendingPathComponent("/users/sign_in"))
            case 404:
                viewController.presentError(.HTTPNotFoundError)
            default:
                viewController.presentError(Error(HTTPStatusCode: statusCode))
            }
        case .networkFailure:
            viewController.presentError(.NetworkError)
        }
    }

    func sessionDidStartRequest(_ session: Session) {
        application.isNetworkActivityIndicatorVisible = true
    }
    
    func sessionDidFinishRequest(_ session: Session) {
        application.isNetworkActivityIndicatorVisible = false
    }
}

extension ApplicationController: AuthenticationControllerDelegate {
    func authenticationControllerDidAuthenticate(_ authenticationController: AuthenticationController) {
        session.reload()
        dismiss(animated: true, completion: nil)
    }
}
