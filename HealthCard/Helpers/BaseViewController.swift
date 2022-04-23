//
//  BaseViewController.swift
//  Level
//
//  Created by Pratik on 17/01/22.
//

import Foundation
import UIKit

class BaseViewController: CompletionLifecycleViewController {
    
}

class CompletionLifecycleViewController: UIViewController {
    typealias VoidCompletion = () -> ()
    
    var didLoad: VoidCompletion = {}
    var didAppear: VoidCompletion = {}
    var didDismiss: VoidCompletion = {}
    var willDismiss: VoidCompletion = {}
    
//    var dataToReturn: (String) -> () = { _ in }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        didLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        didAppear()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        didDismiss()
//        dataToReturn("complete")
    }
}
