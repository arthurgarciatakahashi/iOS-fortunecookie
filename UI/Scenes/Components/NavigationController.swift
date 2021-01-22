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
    
    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        navigationBar.barTintColor = UIColor.darkGray
        navigationBar.tintColor = UIColor.white
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar.isTranslucent = false
    }
}
