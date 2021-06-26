//
//  Router.swift
//  A2AUtilities
//
//  Created by Mohammad Farhan on 9/21/20.
//  Copyright © 2020 A2A. All rights reserved.
//

import UIKit

public enum PresentationType {
    case push
    case present
    case presentWithNavigation
}

public enum Router {
    public static let `default`: NavigationRouter = DefaultRouter()
}

public protocol Navigation { }

public protocol AppNavigation {
    var navigation: Navigation.Type { get }
    
    func viewController(
        for navigation: Navigation,
        sourceViewController: UIViewController?
    ) -> UIViewController
    func navigate(
        using navigation: Navigation,
        from sourceViewController: UIViewController,
        to destinationViewController: UIViewController,
        presentationType: PresentationType,
        modalPresentationStyle: UIModalPresentationStyle
    )
}

public extension AppNavigation {
    @available(iOS 13.0, *)
    func navigate(
        using navigation: Navigation,
        from sourceViewController: UIViewController,
        to destinationViewController: UIViewController,
        presentationType: PresentationType,
        modalPresentationStyle: UIModalPresentationStyle = .automatic
    ) {
        switch presentationType {
        case .push:
            sourceViewController.navigationController?.navigationBar.isTranslucent = true
            sourceViewController.navigationController?.pushViewController(destinationViewController, animated: true)
        case .presentWithNavigation:
            destinationViewController.navigationController?.setNavigationBarHidden(true, animated: false)
            let to = UINavigationController(rootViewController: destinationViewController)
            sourceViewController.navigationController?.present(to, animated: true)
        default:
            destinationViewController.modalPresentationStyle = modalPresentationStyle
            sourceViewController.present(destinationViewController, animated: true)
        }
    }
}

public protocol NavigationRouter {
    func setupAppNavigations(_ appNavigations: [AppNavigation])
    func setupAppNavigation(_ appNavigation: AppNavigation)
    func navigate<T: Navigation>(using navigation: T, from sourceViewController: UIViewController, presentationType: PresentationType, modalPresentationStyle: UIModalPresentationStyle)
    func didNavigate(_ block: @escaping (Navigation) -> Void)
    var appNavigations: [String: AppNavigation] { get }
}

public extension UIViewController {
    @available(iOS 13.0, *)
    func navigate<T: Navigation>(using navigation: T, presentationType: PresentationType = .push, modalPresentationStyle: UIModalPresentationStyle = .automatic) {
        Router.default.navigate(using: navigation, from: self, presentationType: presentationType, modalPresentationStyle: modalPresentationStyle)
    }
}

public class DefaultRouter: NavigationRouter {
    
    public var appNavigations = [String: AppNavigation]()
    var didNavigateBlocks = [((Navigation) -> Void)]()
    
    public func setupAppNavigations(_ appNavigations: [AppNavigation]) {
        appNavigations.forEach { setupAppNavigation($0) }
    }
    
    public func setupAppNavigation(_ appNavigation: AppNavigation) {
        appNavigations[.init(describing: appNavigation.navigation)] = appNavigation
    }
    
    public func navigate<T: Navigation>(
        using navigation: T,
        from sourceViewController: UIViewController,
        presentationType: PresentationType,
        modalPresentationStyle: UIModalPresentationStyle
    ) {
        guard let appNavigation = appNavigations[.init(describing: T.self)] else { return }
        let destinationViewController = appNavigation.viewController(for: navigation, sourceViewController: sourceViewController)
        appNavigation.navigate(
            using: navigation,
            from: sourceViewController,
            to: destinationViewController,
            presentationType: presentationType,
            modalPresentationStyle: modalPresentationStyle
        )
        for block in didNavigateBlocks {
            block(navigation)
        }
    }
    
    public func didNavigate(_ block: @escaping (Navigation) -> Void) {
        didNavigateBlocks.append(block)
    }
}

// Injection helper
public protocol Initializable { init() }
open class RuntimeInjectable: NSObject, Initializable {
    public required override init() {}
}

public func appNavigationFromString(_ appNavigationClassString: String) -> AppNavigation? {
    let appNavClass = NSClassFromString(appNavigationClassString) as? RuntimeInjectable.Type
    let appNav = appNavClass?.init()
    return appNav as? AppNavigation
}
