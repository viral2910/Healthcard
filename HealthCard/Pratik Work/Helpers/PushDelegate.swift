//
//  PushDelegate.swift
//  Level
//
//  Created by Pratik on 15/12/21.
//

import Foundation
import UIKit

protocol PushViewControllerDelegate: AnyObject {
    func pushViewController(vc: UIViewController)
}

protocol presentViewControllersDelegate: AnyObject {
    func present(vc: UIViewController)
}

protocol dismissViewControllersDelegate: AnyObject {
    func dismiss()
}

extension PushViewControllerDelegate where Self: UIViewController {
    func pushViewController(vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension presentViewControllersDelegate where Self: UIViewController {
    func presentViewController(vc: UIViewController) {
        self.present(vc, animated: true)
    }
}

extension dismissViewControllersDelegate where Self: UIViewController {
    func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }
}
