//
//  UIStoryboard.swift
//  A2AUtilities
//
//  Created by Mohammad Farhan on 9/8/20.
//  Copyright © 2020 A2A. All rights reserved.
//

import UIKit

// MARK: - StoryboardIdentifiable

public protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    public static var storyboardIdentifier: String {
        String(describing: self)
    }
    
    public static func instantiate(of storyboard: StoryboardIdentifier = .main) -> Self {
        let storyboard = UIStoryboard(storyboard: storyboard, bundle: Bundle(for: self))
        return storyboard.instantiateViewController()
    }
}

extension UIViewController: StoryboardIdentifiable { }

// MARK: - UIStoryboard

public extension UIStoryboard {
    convenience init(storyboard: StoryboardIdentifier, bundle: Bundle? = nil) {
        self.init(name: storyboard.rawValue, bundle: bundle)
    }
    
    func instantiateViewController<T: UIViewController>() -> T {
        guard let viewController = instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }
        return viewController
    }
}
