//
//  NavigationController.swift
//  UI
//
//  Created by arthur takahashi on 22/01/21.
//  Copyright © 2021 Arthur Takahashi. All rights reserved.
//

import Foundation
import UIKit

public final class NavigationController: UINavigationController {
    private var currentViewControler : UIViewController?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    public convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    private func setup() {
        navigationBar.barTintColor = UIColor.darkGray
        navigationBar.tintColor = UIColor.white
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar.isTranslucent = false
        navigationBar.barStyle = .black
    }
    
    public func setRootViewController(_ viewController: UIViewController) {
        setViewControllers([viewController], animated: true)
        currentViewControler = viewController
        hideBackButtonText()
    }
    
    func hideBackButtonText() {
        currentViewControler?.navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
    }
    
    public func pushViewController(_ viewController: UIViewController) {
        pushViewController(viewController, animated: true)
        currentViewControler = viewController
        hideBackButtonText()
    }
}
